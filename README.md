# handrighting

if errors when cloning:
  1. open ~/.gitconfig file
  2. delete: 
    [filter "lfs"]
      clean = git lfs clean %f
      smudge = git lfs smudge %f
      required = true
  3. rm -rf original clone
  4. try cloning again
