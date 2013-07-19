
bootstrap:
	@wget -O public/bootstrap.zip http://twitter.github.io/bootstrap/assets/bootstrap.zip
	@unzip -d public/ public/bootstrap.zip
	@rm public/bootstrap.zip
