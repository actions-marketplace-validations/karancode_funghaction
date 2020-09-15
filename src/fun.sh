#!/bin/bash

function get_joke {

    JOKE_API_ENDPOINT="https://official-joke-api.appspot.com/random_joke"

    joke=$(curl -s -S -H "accept: application/json" -X GET "${JOKE_API_ENDPOINT}" | jq -r '.setup, .punchline')
    
    do_comment "Joke" "${joke}" "laughing"
}

function get_quote {
    
    QUOTE_API_ENDPOINT="https://api.quotable.io/random"

    quote_json=$(curl -s -S -H "accept: application/json" -X GET "${QUOTE_API_ENDPOINT}")

    
    quote_string=$(echo "${quote_json}" | jq -r '.content')
    quote_author=$(echo "${quote_json}" | jq -r '.author')
    
    quote="${quote_string} - ${quote_author}"
    
    do_comment "Quote" "${quote}" "sunglasses"
}

function get_fact {

    FACT_API_ENDPOINT="https://uselessfacts.jsph.pl/random.json?language=en"
    
    fact=$(curl -s -S -X GET "${FACT_API_ENDPOINT}" | jq -r '.text')

    do_comment "Fact" "${fact}" "astonished"

}

function do_comment {

    type="${1}"
    content="${2}"
    emoji="${3}"
    if [ "${GITHUB_EVENT_NAME}" == "pull_request" ]; then
        
        comment_wrapper="**[${type}] _${content}_** \:${emoji}\:"
        comment_payload=$(echo "${comment_wrapper}" | jq -R --slurp '{body: .}')
        comment_url=$(cat ${GITHUB_EVENT_PATH} | jq -r .pull_request.comments_url)
        echo "${comment_payload}" | curl -s -S -H "Authorization: token ${GITHUB_TOKEN}" --header "Content-Type: application/json" --data @- "${comment_url}" > /dev/null

    fi

    echo ::set-output name=fun_output::${comment_payload}
    exit 0
}
