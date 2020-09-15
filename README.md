# Funghaction (Fun Gtihub Action) <sub>(Pronounced as fung-action :fireworks:)</sub>
`Funghaction` comments any random _quote/joke/fact_ to your Pull Request comment. :sunglasses: :laughing: :astonished:

## Success Criteria
An exit code of `0` is considered a successful execution.

## Usage
The most common usage is to use `Funghaction` with fun type `random`. This will randomly chose either of `quote`/`joke`/`fact`. Acorrdingly a comment will be posted to the pull request depending on the fun typ. This workflow can be configured by adding the following content to the GitHub Actions workflow YAML file.
```yaml
name: 'Funghaction'
on:
  - pull_request
jobs:
  fun:
    name: 'Fun'
    runs-on: ubuntu-latest
    steps:
      - name: 'Fun'
        uses: karancode/funghaction@42
```
Just it! :grin:

## Input

* `fun` - (Optional)) Fun type. One of _[`quote`,`fact`,`joke`]_.

## Output

* `fun_ouput` - The Funghaction comment content.
