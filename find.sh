#!/usr/bin/env bash

set -u

GREEN='\033[1;92m'
WHITE='\033[1;77m'
YELLOW='\033[1;93m'
RED='\033[1;91m'
CYAN='\033[1;96m'
GRAY='\033[1;90m'
RESET='\033[0m'

USERNAME=""
RESULT_FILE=""

banner() {
    printf "${RED}"
    printf "██████╗ ███████╗██████╗  ██████╗ ██╗  ██╗\n"
    printf "██╔══██╗██╔════╝██╔══██╗██╔═══██╗╚██╗██╔╝\n"
    printf "██████╔╝█████╗  ██║  ██║██║   ██║ ╚███╔╝ \n"
    printf "██╔══██╗██╔══╝  ██║  ██║██║   ██║ ██╔██╗ \n"
    printf "██║  ██║███████╗██████╔╝╚██████╔╝██╔╝ ██╗\n"
    printf "╚═╝  ╚═╝╚══════╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝\n"
    printf "${RESET}\n"
    printf "${YELLOW}              REDOX TOOL v1.0${RESET}\n"
    printf "${GRAY}          Public Username Checker${RESET}\n\n"
}

check_dependencies() {
    if ! command -v curl >/dev/null 2>&1; then
        printf "${RED}[!] curl পাওয়া যায়নি.${RESET}\n"
        exit 1
    fi
}

validate_username() {
    if [[ -z "$USERNAME" ]]; then
        printf "${RED}[!] Username খালি রাখা যাবে না.${RESET}\n"
        exit 1
    fi

    if [[ ! "$USERNAME" =~ ^[a-zA-Z0-9._-]+$ ]]; then
        printf "${RED}[!] Invalid username.${RESET}\n"
        exit 1
    fi
}

check_file() {
    RESULT_FILE="${USERNAME}.txt"
    rm -f -- "$RESULT_FILE"
}

check_url() {
    local site="$1"
    local url="$2"
    local status

    printf "${WHITE}[+] %-20s${RESET}" "$site"

    status=$(curl \
        --silent \
        --location \
        --output /dev/null \
        --write-out '%{http_code}' \
        --connect-timeout 8 \
        --max-time 15 \
        --user-agent 'Mozilla/5.0' \
        "$url" 2>/dev/null)

    case "$status" in
        200|201|202|204|301|302|303|307|308)
            printf "${GREEN} Found${RESET}\n"
            printf "%-20s | %-20s | %s\n" "$site" "$USERNAME" "$url" >> "$RESULT_FILE"
            printf "${CYAN}    Profile: ${WHITE}%s${RESET}\n" "$USERNAME"
            printf "${CYAN}    Link:    ${WHITE}%s${RESET}\n" "$url"
            ;;
        404|410)
            printf "${YELLOW} Not Found${RESET}\n"
            ;;
        000)
            printf "${RED} Connection Error${RESET}\n"
            ;;
        *)
            printf "${YELLOW} Unknown (%s)${RESET}\n" "$status"
            ;;
    esac
}

scanner() {
    printf "${GREEN}[>] Checking username:${RESET} ${WHITE}%s${RESET}\n\n" "$USERNAME"

    check_url "Instagram" "https://www.instagram.com/${USERNAME}/"
    check_url "Facebook" "https://www.facebook.com/${USERNAME}"
    check_url "X / Twitter" "https://x.com/${USERNAME}"
    check_url "YouTube" "https://www.youtube.com/@${USERNAME}"
    check_url "Reddit" "https://www.reddit.com/user/${USERNAME}/"
    check_url "Pinterest" "https://www.pinterest.com/${USERNAME}/"
    check_url "VK" "https://vk.com/${USERNAME}"
    check_url "Threads" "https://www.threads.net/@${USERNAME}"
    check_url "Tumblr" "https://${USERNAME}.tumblr.com/"
    check_url "Mastodon" "https://mastodon.social/@${USERNAME}"
    check_url "Bluesky" "https://bsky.app/profile/${USERNAME}.bsky.social"
    check_url "Telegram" "https://t.me/${USERNAME}"

    check_url "GitHub" "https://github.com/${USERNAME}"
    check_url "GitLab" "https://gitlab.com/${USERNAME}"
    check_url "Bitbucket" "https://bitbucket.org/${USERNAME}"
    check_url "Codeberg" "https://codeberg.org/${USERNAME}"
    check_url "SourceForge" "https://sourceforge.net/u/${USERNAME}/profile/"
    check_url "Replit" "https://replit.com/@${USERNAME}"
    check_url "CodePen" "https://codepen.io/${USERNAME}"
    check_url "JSFiddle" "https://jsfiddle.net/user/${USERNAME}/"
    check_url "Dev.to" "https://dev.to/${USERNAME}"
    check_url "Hashnode" "https://hashnode.com/@${USERNAME}"
    check_url "Kaggle" "https://www.kaggle.com/${USERNAME}"
    check_url "LeetCode" "https://leetcode.com/u/${USERNAME}/"
    check_url "Hugging Face" "https://huggingface.co/${USERNAME}"
    check_url "Docker Hub" "https://hub.docker.com/u/${USERNAME}"
    check_url "NPM" "https://www.npmjs.com/~${USERNAME}"
    check_url "PyPI" "https://pypi.org/user/${USERNAME}/"

    check_url "Behance" "https://www.behance.net/${USERNAME}"
    check_url "Dribbble" "https://dribbble.com/${USERNAME}"
    check_url "DeviantArt" "https://www.deviantart.com/${USERNAME}"
    check_url "ArtStation" "https://www.artstation.com/${USERNAME}"
    check_url "Unsplash" "https://unsplash.com/@${USERNAME}"
    check_url "Pexels" "https://www.pexels.com/@${USERNAME}/"
    check_url "Flickr" "https://www.flickr.com/people/${USERNAME}/"
    check_url "500px" "https://500px.com/p/${USERNAME}"
    check_url "Vimeo" "https://vimeo.com/${USERNAME}"

    check_url "Medium" "https://medium.com/@${USERNAME}"
    check_url "Wattpad" "https://www.wattpad.com/user/${USERNAME}"
    check_url "Substack" "https://${USERNAME}.substack.com/"
    check_url "Blogger" "https://${USERNAME}.blogspot.com/"
    check_url "LiveJournal" "https://${USERNAME}.livejournal.com/"
    check_url "Write.as" "https://write.as/${USERNAME}"
    check_url "Scribd" "https://www.scribd.com/${USERNAME}"
    check_url "Issuu" "https://issuu.com/${USERNAME}"
    check_url "SlideShare" "https://www.slideshare.net/${USERNAME}"

    check_url "SoundCloud" "https://soundcloud.com/${USERNAME}"
    check_url "Mixcloud" "https://www.mixcloud.com/${USERNAME}/"
    check_url "Last.fm" "https://www.last.fm/user/${USERNAME}"
    check_url "Audiomack" "https://audiomack.com/${USERNAME}"
    check_url "BandLab" "https://www.bandlab.com/${USERNAME}"
    check_url "Audius" "https://audius.co/${USERNAME}"
    check_url "ReverbNation" "https://www.reverbnation.com/${USERNAME}"
    check_url "Bandcamp" "https://${USERNAME}.bandcamp.com/"

    check_url "Steam" "https://steamcommunity.com/id/${USERNAME}"
    check_url "Twitch" "https://www.twitch.tv/${USERNAME}"
    check_url "Kick" "https://kick.com/${USERNAME}"
    check_url "Chess.com" "https://www.chess.com/member/${USERNAME}"
    check_url "Lichess" "https://lichess.org/@/${USERNAME}"
    check_url "Itch.io" "https://${USERNAME}.itch.io/"
    check_url "Game Jolt" "https://gamejolt.com/@${USERNAME}"
    check_url "NameMC" "https://namemc.com/profile/${USERNAME}"

    check_url "LinkedIn" "https://www.linkedin.com/in/${USERNAME}/"
    check_url "ORCID" "https://orcid.org/${USERNAME}"
    check_url "ResearchGate" "https://www.researchgate.net/profile/${USERNAME}"
    check_url "Product Hunt" "https://www.producthunt.com/@${USERNAME}"
    check_url "Wellfound" "https://wellfound.com/u/${USERNAME}"
    check_url "Indie Hackers" "https://www.indiehackers.com/${USERNAME}"
    check_url "Foursquare" "https://foursquare.com/user/${USERNAME}"
    check_url "Disqus" "https://disqus.com/by/${USERNAME}/"

    check_url "Patreon" "https://www.patreon.com/${USERNAME}"
    check_url "Gumroad" "https://gumroad.com/${USERNAME}"
    check_url "Etsy" "https://www.etsy.com/shop/${USERNAME}"
    check_url "eBay" "https://www.ebay.com/usr/${USERNAME}"
    check_url "Canva" "https://www.canva.com/p/${USERNAME}"

    check_url "Keybase" "https://keybase.io/${USERNAME}"
    check_url "Pastebin" "https://pastebin.com/u/${USERNAME}"
    check_url "Goodreads" "https://www.goodreads.com/${USERNAME}"
    check_url "About.me" "https://about.me/${USERNAME}"
    check_url "Newgrounds" "https://${USERNAME}.newgrounds.com/"
    check_url "Trakt" "https://www.trakt.tv/users/${USERNAME}"
    check_url "Hacker News" "https://news.ycombinator.com/user?id=${USERNAME}"
    check_url "Wikipedia" "https://en.wikipedia.org/wiki/User:${USERNAME}"

    printf "\n"
}

summary() {
    if [[ -s "$RESULT_FILE" ]]; then
        local count
        count=$(wc -l < "$RESULT_FILE")

        printf "${GREEN}[+] Scan completed.${RESET}\n"
        printf "${GREEN}[+] Profiles found: ${WHITE}%s${RESET}\n" "$count"
        printf "${GREEN}[+] Results: ${WHITE}%s${RESET}\n" "$RESULT_FILE"
    else
        printf "${YELLOW}[!] কোনো profile পাওয়া যায়নি.${RESET}\n"
    fi
}

main() {
    clear 2>/dev/null || true
    banner
    check_dependencies

    read -r -p "$(printf "${GREEN}[>] Input Username: ${RESET}")" USERNAME

    printf "\n"

    validate_username
    check_file
    scanner
    summary
}

main

