REPO_DIR=$(shell pwd)

help:
	@echo "\SCRIPTS\n"
	@echo "make github.contributors        # pull a list of all contributors"
	@echo "make github.issues       	   # pull a list of all issue creators"
	@echo "make github.traction       	   # get a history of stargazers for our individual repos"

github.users:
	curl -sS https://api.github.com/repos/supabase/monorepo/contributors \
	| jq -r 'map_values({username: .login, avatar_url: .avatar_url}) \
	| unique \
	| sort_by(.username)' \
	> $(REPO_DIR)/web/src/data/contributors/contributors.json

github.issues:
	curl -sS https://api.github.com/repos/supabase/monorepo/issues \
	| jq -r 'map_values({username: .user.login, avatar_url: .user.avatar_url}) \
	| unique \
	| sort_by(.username)' \
	> $(REPO_DIR)/web/src/data/contributors/issues.json

github.traction: \
	cd web && npm run traction