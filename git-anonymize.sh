#!/bin/sh
#Forked from https://gist.github.com/pozorvlak/8784840
# Suppose you want to do blind reviewing of code (eg for job interview
# purposes). Unfortunately, the candidates' names and email addresses are
# stored on every commit! You probably want to assess each candidate's version
# control practices, so just `rm -rf .git` throws away too much information.
# Here's what you can do instead.

# Rewrite all commits to hide the author's name and email

#Remove the name of the repository 
git reflog expire --expire=90.days.ago --expire-unreachable=now --all
for branch in `ls .git/refs/heads`; do
	    # We may be doing multiple rewrites, so we must force subsequent ones.
	        # We're throwing away the backups anyway.
		    git filter-branch -f --env-filter '
		            export GIT_AUTHOR_NAME="Anonymous Candidate"
			            export GIT_AUTHOR_EMAIL="anon@example.com"' $branch
		#Adding cleaning of GIT_COMMITTER clean up as well
                    git filter-branch -f --env-filter '
		                    export GIT_COMMITTER_NAME="Anonymous Candidate"
			            export GIT_COMMITTER_EMAIL="anon@example.com"' $branch
			    done

			   #GIT_COMMITTER_NAME sets the human name for the “committer” field.

			    #GIT_COMMITTER_EMAIL is the email address for the “committer” field.
			    # Delete the old commits
			    rm -rf .git/refs/original/

			    # Delete remotes, which might point to the old commits
			    for r in `git remote`; do git remote rm $r; done

			    # Your old commits will now no longer show up in GitK, `git log` or `git
			    # reflog`, but can still be found using `git show $commit-id`.
