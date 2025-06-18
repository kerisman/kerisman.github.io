build:
	zola build

serve:
	zola serve --drafts

publish:
	./build.sh

find-drafts:
	@grep -rl 'draft = true' content/blog

find-ready:
	@grep -rl 'draft = false' content/blog
