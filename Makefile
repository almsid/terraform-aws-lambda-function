test:
	@echo "Packaging test fixture..."
	@cd tests/fixtures && zip -r payload.zip index.py
	@echo "Running Terraform tests..."
	@terraform test