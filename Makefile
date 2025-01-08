# Variabel
OUTPUT = output.pdf
REPORT_DIR = report
ASSETS_DIR = $(REPORT_DIR)/assets
TEMPLATES_DIR = $(ASSETS_DIR)/templates
SECTIONS_DIR = $(REPORT_DIR)/sections
METADATA = $(REPORT_DIR)/metadata.yml
BIBLIOGRAPHY = $(REPORT_DIR)/references.bib
TEMPLATE = $(TEMPLATES_DIR)/Eisvogel.tex

# Daftar file markdown
SECTIONS = $(wildcard $(SECTIONS_DIR)/*.md)

# Default target
all: $(OUTPUT)

# Target untuk menghasilkan PDF
$(OUTPUT): $(METADATA) $(SECTIONS) $(BIBLIOGRAPHY) $(TEMPLATE)
	@pandoc -s \
		--metadata-file=$(METADATA) \
		--from markdown \
		--to pdf \
		--template=$(TEMPLATE) \
		--bibliography=$(BIBLIOGRAPHY) \
		--output=$(OUTPUT) \
		$(SECTIONS)

# Membersihkan file sementara
clean:
	@rm -f $(OUTPUT)

# Target bantuan
help:
	@echo "Makefile untuk proyek laporan"
	@echo "Target yang tersedia:"
	@echo "  all       : Membuat file PDF laporan ($(OUTPUT))"
	@echo "  clean     : Membersihkan file sementara"
	@echo "  help      : Menampilkan pesan bantuan"

.PHONY: all clean help