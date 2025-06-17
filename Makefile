build:
	zola build

serve:
	zola serve --drafts

publish:
	./build.sh

list-drafts:
	@grep -rl 'draft = true' content/posts

list-ready:
	@grep -rl 'draft = false' content/posts
