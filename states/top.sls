base:
  '*':
    - backend
  'I@modules.frontend.use:true':
    - frontend
    - common
  'I@modules.aws.use:true':
    - aws
  'I@modules.docker.use:true':
    - docker
  'I@modules.repomgmt.bitbucket.use:true':
    - bitbucket
  'I@modules.repomgmt.github.use:true':
    - github

