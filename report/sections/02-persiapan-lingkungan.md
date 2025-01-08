# Persiapan Lingkungan

## Spesifikasi Hardware

### Spesifikasi untuk Server:

- **CPU**: Arsitektur **x86_64** atau **aarch64**.
- **RAM**: Minimal 2 GB.
- **Storage**: Minimal 8 GB ruang penyimpanan.
- **Peripherals**: Mendukung perangkat keras umum, kecuali untuk beberapa
  perangkat khusus yang memerlukan driver tambahan.

### Spesifikasi untuk Desktop (Client):

- **CPU**: Arsitektur **x86_64** atau **aarch64**.
- **RAM**: Minimal 1 GB.
- **Storage**: Minimal 4 GB ruang penyimpanan.
- **Peripherals**: Mendukung perangkat keras umum, dengan kompatibilitas GPU
  Intel, ATI/AMD, atau Nvidia (beberapa model).

## Instalasi Homebrew (MacOS)

Jika Anda belum memiliki **Homebrew** (untuk pengguna macOS atau Linux), Anda
dapat menginstalnya dengan menjalankan perintah berikut di terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Setelah selesai, Anda dapat memastikan Homebrew telah terinstal dengan
menjalankan perintah:

```bash
brew --version
```

Jika Homebrew terinstal dengan benar, akan muncul informasi versi Homebrew.

## Instalasi QEMU (MacOS)

Setelah Homebrew terinstal, Anda bisa melanjutkan dengan instalasi QEMU
menggunakan perintah berikut:

```bash
brew install qemu
```

## Penyiapan Skrip QEMU untuk Server dan Client

### Skrip QEMU untuk Server

Buat skrip untuk menjalankan mesin virtual server dengan konfigurasi yang
sesuai. Berikut adalah contoh skrip untuk menjalankan server:

```bash
#!sudo /bin/bash
# Skrip untuk mengelola VM berbasis QEMU untuk Alpine Linux (aarch64)

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")
VM_NAME="${SCRIPT_NAME%.sh}"
ISO_URL="https://dl-cdn.alpinelinux.org/alpine/v3.21/releases/aarch64/alpine-virt-3.21.0-aarch64.iso"

# Fungsi untuk membuat disk virtual
create_disk() {
    qemu-img create -f vdi "$1" 1G
}

# Fungsi untuk mengunduh file ISO
download_iso() {
    local url="$1"
    local output="$2"
    if ! curl -# -L "$url" -o "$output" --fail; then
        echo "Error: Gagal mengunduh ISO dari $url" >&2
        exit 1
    fi
}

# Fungsi untuk membersihkan sumber daya
clean() {
    echo "Membersihkan sumber daya..."
    rm -f "${SCRIPT_DIR}/resources/${VM_NAME}.vdi"
    rm -f "${SCRIPT_DIR}/resources/${VM_NAME}.fd"
    echo "Pembersihan selesai."
}

# Fungsi untuk menjalankan VM
run_vm() {
    local accel=""
    if [ "$(uname)" = "Darwin" ]; then
        accel="-accel hvf -cpu host"
    fi

    clear
    qemu-system-aarch64 \
        -name "$VM_NAME" \
        -machine virt \
        -smp 2 \
        -m 1G \
        -drive if=pflash,format=raw,file="${SCRIPT_DIR}/resources/edk2-aarch64-code.fd",readonly=on \
        -drive if=pflash,format=raw,file="${SCRIPT_DIR}/resources/${VM_NAME}.fd" \
        -drive "file=${SCRIPT_DIR}/resources/${VM_NAME}.vdi,format=vdi,if=virtio" \
        -drive "file=fat:rw:${SCRIPT_DIR}/shared,media=disk,format=raw" \
        -nic vmnet-shared \
        -nic vmnet-bridged,ifname=en0 \
        -nographic $accel "$@"
}

# Fungsi untuk menginstal VM menggunakan ISO
install() {
    kdir -p "${SCRIPT_DIR}/resources"

    # Buat disk virtual jika belum ada
    if [ ! -f "${SCRIPT_DIR}/resources/${VM_NAME}.vdi" ]; then
        create_disk "${SCRIPT_DIR}/resources/${VM_NAME}.vdi"
    fi

    # Salin firmware jika belum ada
    if [ ! -f "${SCRIPT_DIR}/resources/${VM_NAME}.fd" ]; then
        cp "${SCRIPT_DIR}/resources/edk2-aarch64-code.fd" "${SCRIPT_DIR}/resources/${VM_NAME}.fd"
    fi

    # Download iso file jika belum ada
    local iso_path="${SCRIPT_DIR}/resources/$(basename $ISO_URL)"
    if [ ! -f "$iso_path" ]; then
        download_iso "$ISO_URL" "$iso_path"
    fi

    run_vm -cdrom "$iso_path" "$@"
}

# Fungsi utama
main() {
    # Pilih aksi berdasarkan argumen pertama
    case "$1" in
        clean)
            clean
            ;;
        install)
            install "${@:2}"
            ;;
        *)
            run_vm "$@"
            ;;
    esac
}

main "$@"

```

Simpan skrip dengan nama yang sesuai misal `alpine-aarch64-virt`

### Skrip QEMU untuk Client

Buat skrip yang serupa untuk menjalankan mesin virtual desktop (client):

```bash
#!sudo /bin/bash
# Skrip untuk mengelola VM berbasis QEMU untuk Alpine Linux (aarch64)

export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

SCRIPT_DIR=$(dirname "${BASH_SOURCE[0]}")
SCRIPT_NAME=$(basename "${BASH_SOURCE[0]}")
VM_NAME="${SCRIPT_NAME%.sh}"
ISO_URL="https://dl-cdn.alpinelinux.org/alpine/v3.21/releases/aarch64/alpine-virt-3.21.0-aarch64.iso"

# Fungsi untuk membuat disk virtual
create_disk() {
    qemu-img create -f vdi "$1" 1G
}

# Fungsi untuk mengunduh file ISO
download_iso() {
    local url="$1"
    local output="$2"
    if ! curl -# -L "$url" -o "$output" --fail; then
        echo "Error: Gagal mengunduh ISO dari $url" >&2
        exit 1
    fi
}

# Fungsi untuk membersihkan sumber daya
clean() {
    echo "Membersihkan sumber daya..."
    rm -f "${SCRIPT_DIR}/resources/${VM_NAME}.vdi"
    rm -f "${SCRIPT_DIR}/resources/${VM_NAME}.fd"
    echo "Pembersihan selesai."
}

# Fungsi untuk menjalankan VM
run_vm() {
    local accel=""
    if [ "$(uname)" = "Darwin" ]; then
        accel="-accel hvf -cpu host"
    fi

    clear
    qemu-system-aarch64 \
        -name "$VM_NAME" \
        -machine virt \
        -smp 2 \
        -m 1G \
        -drive if=pflash,format=raw,file="${SCRIPT_DIR}/resources/edk2-aarch64-code.fd",readonly=on \
        -drive if=pflash,format=raw,file="${SCRIPT_DIR}/resources/${VM_NAME}.fd" \
        -drive "file=${SCRIPT_DIR}/resources/${VM_NAME}.vdi,format=vdi,if=virtio" \
        -drive "file=fat:rw:${SCRIPT_DIR}/shared,media=disk,format=raw" \
        -nic vmnet-shared \
        -nic vmnet-bridged,ifname=en0 \
        -device virtio-gpu-pci \
        -device qemu-xhci \
        -device usb-kbd \
        -device usb-tablet \
        -device virtio-sound,streams=1 $accel "$@"
}

# Fungsi untuk menginstal VM menggunakan ISO
install() {
    mkdir -p "${SCRIPT_DIR}/resources"

    # Buat disk virtual jika belum ada
    if [ ! -f "${SCRIPT_DIR}/resources/${VM_NAME}.vdi" ]; then
        create_disk "${SCRIPT_DIR}/resources/${VM_NAME}.vdi"
    fi

    # Salin firmware jika belum ada
    if [ ! -f "${SCRIPT_DIR}/resources/${VM_NAME}.fd" ]; then
        cp "${SCRIPT_DIR}/resources/edk2-aarch64-code.fd" "${SCRIPT_DIR}/resources/${VM_NAME}.fd"
    fi

    # Download iso file jika belum ada
    local iso_path="${SCRIPT_DIR}/resources/$(basename $ISO_URL)"
    if [ ! -f "$iso_path" ]; then
        download_iso "$ISO_URL" "$iso_path"
    fi

    run_vm -cdrom "$iso_path" "$@"
}

# Fungsi utama
main() {
    # Pilih aksi berdasarkan argumen pertama
    case "$1" in
        clean)
            clean
            ;;
        install)
            install "${@:2}"
            ;;
        *)
            run_vm "$@"
            ;;
    esac
}

main "$@"

```

Simpan skrip dengan nama yang sesuai misal `alpine-aarch64-desktop`

## Memberikan Izin Eksekusi pada Skrip

Setelah membuat kedua skrip tersebut, Anda perlu memberikan izin eksekusi agar
dapat menjalankannya sebagai program. Gunakan perintah chmod +x untuk memberikan
izin eksekusi pada kedua skrip:

```bash
chmod +x alpine-aarch64-virt
chmod +x alpine-aarch64-desktop
```

Sesuaikan nama skrip `alpine-aarch64-virt` dan `alpine-aarch64-desktop`
berdasarkan skrip yang dibuat sebelumnya.
