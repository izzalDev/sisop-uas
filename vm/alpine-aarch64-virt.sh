#!/bin/bash

# Mengabaikan fork safety untuk ObjectiveC (diperlukan untuk macOS)
# Ini diperlukan untuk menghindari crash pada sistem macOS saat melakukan fork process
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# ========== PATH CONFIGURATION ==========
# Mendapatkan direktori tempat script ini berada
# Berguna untuk referensi relatif terhadap lokasi script
CURRENT_PATH=$(dirname "${BASH_SOURCE[0]}")

# Path ke direktori resources yang berisi file-file pendukung
# Seperti disk image, ISO, dan firmware
RESOURCES_PATH="${CURRENT_PATH}/resources"

# Nama file script ini tanpa path
# Digunakan untuk membuat nama default untuk disk dan titlebar
FILENAME=$(basename "${BASH_SOURCE[0]}")

# ========== VM CONFIGURATION ==========
# Arsitektur CPU yang akan diemulasikan
# aarch64: 64-bit ARM architecture (Apple Silicon, modern ARM processors)
# x86_64: Arsitektur x86 64-bit (digunakan pada prosesor Intel dan AMD)
ARCH="aarch64"

# Jumlah core CPU yang dialokasikan untuk VM
# Sesuaikan dengan kebutuhan dan kemampuan host system
CPU_CORES=2

# Ukuran RAM yang dialokasikan untuk VM
# Format: <angka>[K|M|G] (Kilobyte, Megabyte, Gigabyte)
RAM_SIZE="1G"

# Ukuran disk virtual yang akan dibuat
# Format: <angka>[K|M|G] (Kilobyte, Megabyte, Gigabyte)
DISK_SIZE="1G"

# Nama file disk virtual
# Dibuat berdasarkan nama script dengan ekstensi .vdi
# .vdi adalah format VirtualBox disk image yang kompatibel dengan QEMU
DISK_NAME="${FILENAME%.sh}.vdi"

# File ISO yang akan digunakan untuk instalasi
# ISO_FILE dapat berisi URL atau nama file yang ada di direktori resources
# Jika nama file URL dan nama file di direktori resources sama akan digunakan
# file yang ada di direktori resources
ISO_FILE="alpine-virt-3.21.0-aarch64.iso"

# Nama yang akan ditampilkan di title bar window VM
# Diambil dari nama script tanpa ekstensi .sh
TITLEBAR="${FILENAME%.sh}"

# Mode default yang digunakan saat menjalankan VM
# 'base': Mode dengan GUI standard
# Alternatif: 'nographic' untuk mode tanpa GUI, 'core' untuk mode minimal
DEFAULT_MODE="base"

# Argumen tambahan untuk QEMU
# Dapat diisi sesuai kebutuhan, misal: untuk networking atau device tambahan
ARGS=""

# Fungsi untuk memeriksa apakah disk kosong
is_disk_empty() {
    local json=$(qemu-img info --output=json "$1" 2>/dev/null)
    local vsize=$(echo "$json" | grep -o '"virtual-size":[^,]*' | awk -F: '{print $2}' | tr -d ' ')
    local asize=$(echo "$json" | grep -o '"actual-size":[^,]*' | awk -F: '{print $2}' | tr -d ' ')
    (( asize <= 4 * (vsize / 1048576) + 4096 ))
}

# Fungsi untuk validasi URL
is_url() {
    local url="$1"
    [[ "$url" =~ ^https?://[a-zA-Z0-9.-]+(\:[0-9]+)?(/[^ ]*)?$ ]]
}

# Fungsi untuk mengunduh ISO
download_iso() {
    local url="$1"
    local output="${2:-$(basename "$url")}"
    
    if curl -L "$url" -o "$output"; then
        echo "Unduhan berhasil: $output"
        return 0
    else
        echo "Unduhan gagal."
        return 1
    fi
}

# Fungsi untuk membuat disk virtual
create_disk() {
    qemu-img create -f vdi "$1" "$2"
}

# Fungsi inti QEMU
core() {
    local machine_type
    [ "$ARCH" = "aarch64" ] && machine_type="virt" || machine_type="q35"
    
    local accel_option
    [ "$(uname)" = "Darwin" ] && accel_option="-accel hvf -cpu host" || accel_option=""
    
    qemu-system-${ARCH} \
        -name "$TITLEBAR" \
        -machine "$machine_type" \
        -smp "$CPU_CORES" \
        -m "$RAM_SIZE" \
        -bios "${RESOURCES_PATH}/QEMU_EFI_STABLE.fd" \
        -drive "file=${RESOURCES_PATH}/${DISK_NAME},format=vdi,if=virtio" \
        -drive "file=fat:rw:${CURRENT_PATH}/shared,media=disk,format=raw" \
        ${accel_option} ${ARGS} "$@"
}

# Mode base dengan GUI
base() {
    core \
        -device virtio-gpu-pci \
        -display default,show-cursor=on \
        -device qemu-xhci \
        -device usb-kbd \
        -device usb-tablet \
        -device virtio-sound,streams=1 \
        -daemonize "$@"
}

# Mode tanpa GUI
nographic() {
    core -nographic "$@"
}

# Fungsi untuk menjalankan VM
run() {
    case "$1" in
        nographic)
            nographic "${@:2}"
            ;;
        core)
            core "${@:2}"
            ;;
        *)
            $DEFAULT_MODE "$@"
            ;;
    esac
}

# Main script
main() {
    # Cek dan buat disk image jika belum ada
    if [ ! -f "${RESOURCES_PATH}/${DISK_NAME}" ]; then
        echo "Disk image ${RESOURCES_PATH}/${DISK_NAME} tidak ditemukan"
        echo "Membuat disk image ..."
        create_disk "${RESOURCES_PATH}/${DISK_NAME}" "${DISK_SIZE}"
    fi

    # Jika disk kosong, siapkan dengan ISO
    if is_disk_empty "${RESOURCES_PATH}/${DISK_NAME}"; then
        local iso_path="${RESOURCES_PATH}/$(basename "$ISO_FILE")"
        echo "Disk image kosong."
        echo "Mencari iso file."
        
        if is_url "$ISO_FILE" && [ ! -f "$iso_path" ]; then
            download_iso "$ISO_FILE" "${RESOURCES_PATH}/${ISO_FILE}"
        fi

        if [ ! -f "$iso_path" ]; then
            echo "File ISO ${RESOURCES_PATH}/${ISO_FILE} tidak ditemukan."
            exit 1
        fi
        
        run "$1" -cdrom "$iso_path"
    else
        run "$@"
    fi
}

# Jalankan script
main "$@"