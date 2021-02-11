# How To Loop Through Filenames With Spaces Using Bash

If you need to loop through filenames with spaces, use a combination of `find` and `for`

```bash
find . -maxdepth 1 -type d -not -path "." -exec sh -c '
  for folder do
    echo "$folder"
    mv "$folder" $(echo "${folder}" | sed "s|\ |_|g")
  done
' exec-sh {} +
```