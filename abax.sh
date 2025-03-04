#!/bin/bash

# Record start time with nanosecond precision
start_time=$(date +%s.%N)

# Define colors for better output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
PINK='\033[0;95m'  # Light magenta/pink
BOLD_PINK='\033[1;95m'  # Bold light magenta/pink
BRIGHT_BLUE='\033[0;95m'  # Bright blue for input prompts
NC='\033[0m' # No Color

# Display ABAX ASCII art logo
echo -e "${CYAN}"
echo '   _    ____    _    __  __'
echo '  / \  | __ )  / \   \ \/ /'
echo ' / _ \ |  _ \ / _ \   \  / '
echo '/ ___ \| |_) / ___ \  /  \ '
echo '/_/   \_\____/_/   \_\/_/\_\'
echo -e "${NC}"
echo -e "${BLUE}== Code Statistics Tool ==${NC}"
echo -e "${BLUE}This script counts lines, characters, and tokens in your codebase${NC}"
echo -e "${BLUE}--------------------------------------------------------${NC}"

# Default directories to exclude
DEFAULT_EXCLUDE_DIRS="node_modules .next"

# Ask user about exclusions
echo -e "${BRIGHT_BLUE}Would you like to use the default directory exclusions (node_modules, .next)? (y/n)${NC}"
read -p "> " use_default_exclusions

if [[ $use_default_exclusions =~ ^[Yy]$ ]]; then
    EXCLUDE_DIRS="$DEFAULT_EXCLUDE_DIRS"
    echo -e "${GREEN}Using default exclusions: $EXCLUDE_DIRS${NC}"
else
    echo -e "${BRIGHT_BLUE}Please enter directories to exclude (space-separated, press Enter when done):${NC}"
    echo -e "${BRIGHT_BLUE}Example: dist build temp cache${NC}"
    read -p "> " custom_exclude_dirs
    
    if [ -z "$custom_exclude_dirs" ]; then
        EXCLUDE_DIRS=""
        echo -e "${YELLOW}No custom directories specified. Only .git will be excluded.${NC}"
    else
        EXCLUDE_DIRS="$custom_exclude_dirs"
        echo -e "${GREEN}Using custom exclusions: $EXCLUDE_DIRS${NC}"
    fi
fi

# Prepare find command exclusion parameters
FIND_EXCLUSIONS="-not -path \"*/.git/*\""  # Always exclude .git
for dir in $EXCLUDE_DIRS; do
    FIND_EXCLUSIONS="$FIND_EXCLUSIONS -not -path \"*/$dir/*\""
done

# Define binary/media file extensions to exclude
BINARY_EXTENSIONS="png|jpg|jpeg|gif|ico|svg|mp4|mp3|wav|pdf|ttf|woff|woff2|eot|DS_Store|tsbuildinfo"

echo -e "${BLUE}Counting lines, characters, and estimated tokens in the repository...${NC}"
echo -e "${BLUE}Excluding: .git directory (always excluded), binary files, and:${NC} ${YELLOW}$EXCLUDE_DIRS${NC}"
echo -e "${BLUE}--------------------------------------------------------${NC}"

# Count total files (excluding binary files)
total_files_cmd="find . -type f $FIND_EXCLUSIONS | grep -v -E \"\.(${BINARY_EXTENSIONS})$\" | wc -l"
total_files=$(eval $total_files_cmd)
echo -e "${GREEN}Total text files:${NC} $total_files"

# Count binary files
binary_files_cmd="find . -type f $FIND_EXCLUSIONS | grep -E \"\.(${BINARY_EXTENSIONS})$\" | wc -l"
binary_files=$(eval $binary_files_cmd)
echo -e "${YELLOW}Binary/media files (not counted in line total):${NC} $binary_files"

# Count total lines and characters (excluding binary files)
total_stats_cmd="find . -type f $FIND_EXCLUSIONS | grep -v -E \"\.(${BINARY_EXTENSIONS})$\" | xargs wc -l -c 2>/dev/null | tail -n 1"
total_stats=$(eval $total_stats_cmd)
total_lines=$(echo "$total_stats" | awk '{print $1}')
total_chars=$(echo "$total_stats" | awk '{print $2}')
total_tokens=$(echo "$total_chars / 4" | bc)

echo -e "${GREEN}Total lines of code:${NC} $total_lines"
echo -e "${CYAN}Total characters:${NC} $total_chars"
echo -e "${PURPLE}Estimated tokens (1 token ≈ 4 chars):${NC} $total_tokens"

# Count lines and characters by file extension (excluding binary files)
echo -e "\n${GREEN}Lines, characters, and estimated tokens by file extension:${NC}"
printf "${BLUE}%-10s %8s %15s %17s %17s${NC}\n" "Extension" "Files" "Lines" "Characters" "Est. Tokens"
printf "%s\n" "------------------------------------------------------------------------"

extensions_cmd="find . -type f $FIND_EXCLUSIONS | grep -v \"count-lines.sh\" | grep -v -E \"\.(${BINARY_EXTENSIONS})$\" | sed 's/.*\.//' | sort | uniq -c | sort -nr"
eval $extensions_cmd | while read count ext; do
    if [ "$ext" != "" ]; then
        # Get line and character count for this extension
        ext_stats_cmd="find . -type f -name \"*.$ext\" $FIND_EXCLUSIONS | xargs wc -l -c 2>/dev/null | tail -n 1"
        ext_stats=$(eval $ext_stats_cmd)
        ext_lines=$(echo "$ext_stats" | awk '{print $1}')
        ext_chars=$(echo "$ext_stats" | awk '{print $2}')
        ext_tokens=$(echo "$ext_chars / 4" | bc)
        
        if [ "$ext_lines" != "" ] && [ "$ext_chars" != "" ]; then
            printf "${BLUE}%-10s${NC} %8d %15d %17d %17d\n" ".$ext" $count $ext_lines $ext_chars $ext_tokens
        fi
    fi
done

# Show counted binary files (but not their lines)
echo -e "\n${YELLOW}Binary/media files (not counted for lines/characters/tokens):${NC}"
binary_extensions_cmd="find . -type f $FIND_EXCLUSIONS | grep -E \"\.(${BINARY_EXTENSIONS})$\" | sed 's/.*\.//' | sort | uniq -c | sort -nr"
eval $binary_extensions_cmd | while read count ext; do
    if [ "$ext" != "" ]; then
        printf "${YELLOW}%-10s${NC} %8d files\n" ".$ext" $count
    fi
done

echo -e "\n${BOLD_PINK}Note: .git directory is always excluded as it contains binary files and repository metadata.${NC}"
echo -e "${BOLD_PINK}Token estimation disclaimer: Token counts are estimated using a simple 4 characters = 1 token ratio.${NC}"
echo -e "${BOLD_PINK}Actual token counts may vary based on the tokenization algorithm used by different models.${NC}"

# Calculate and display execution time with millisecond precision
end_time=$(date +%s.%N)
duration=$(echo "$end_time - $start_time" | bc)
duration_ms=$(echo "$duration * 1000 / 1" | bc)

# Extract the components for formatting
seconds=$(echo "$duration / 1" | bc)
milliseconds=$(echo "$duration_ms % 1000" | bc)

# Format the duration including milliseconds
if [ $seconds -ge 60 ]; then
    minutes=$((seconds / 60))
    seconds=$((seconds % 60))
    echo -e "\n${CYAN}Script execution time: ${minutes}m ${seconds}s ${milliseconds}ms${NC}"
else
    echo -e "\n${CYAN}Script execution time: ${seconds}s ${milliseconds}ms${NC}"
fi 