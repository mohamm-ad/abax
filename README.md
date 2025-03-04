# Abax - Code Statistics Tool

Abax is a simple shell script that provides statistics about your codebase, including line counts, character counts, and very rough token estimations. This tool is particularly useful for developers who want to understand the size and composition of their repositories or estimate token usage for large language models.

## Features

- 📊 **Detailed Statistics**: Count lines, characters, and estimate tokens in your codebase
- 🔍 **File Type Breakdown**: Get statistics broken down by file extension
- 🚫 **Customizable Exclusions**: Specify which directories to exclude from counting
- 📏 **Token Estimation**: Customize the character-to-token ratio for more accurate estimations
- 🖼️ **Binary File Handling**: Automatic detection and separate reporting of binary/media files
- ⏱️ **Performance Metrics**: Displays execution time for performance monitoring

## Installation

1. Download the `abax.sh` script to your repository:

```bash
curl -o abax.sh https://raw.githubusercontent.com/mohamm-ad/abax/main/abax.sh
```

2. Make the script executable:

```bash
chmod +x abax.sh
```

## Usage

Run the script from the root directory of your repository:

```bash
./abax.sh
```

> **Note:** For accurate statistics, always run Abax from the root directory of your project repository.

### Interactive Options

The script will prompt you for:

1. **Directory Exclusions**: 
   - Choose whether to use default exclusions (`node_modules`, `.next`)
   - Or specify custom directories to exclude

2. **Token Estimation Ratio**: 
   - Use the default ratio (4 characters = 1 token)
   - Or specify a custom ratio for more accurate estimations

### Example Output

<pre style="line-height:1.2">
<span style="color:#0000ff">┌────────────────────────────────────────────┐</span>
<span style="color:#0000ff">│</span>                                            <span style="color:#0000ff">│</span>
<span style="color:#0000ff">│</span>  <span style="color:#00ffff; font-weight:bold">    █████</span><span style="color:#ff0000">╗</span> <span style="color:#00ff00">██████</span><span style="color:#ff0000">╗</span> <span style="color:#ffff00">█████</span><span style="color:#ff0000">╗</span> <span style="color:#800080">██</span><span style="color:#ff0000">╗  </span><span style="color:#800080">██</span><span style="color:#ff0000">╗</span>  <span style="color:#0000ff">│</span>
<span style="color:#0000ff">│</span>  <span style="color:#00ffff; font-weight:bold">   ██</span><span style="color:#ff0000">╔══</span><span style="color:#00ffff">██</span><span style="color:#ff0000">╗</span><span style="color:#00ff00">██</span><span style="color:#ff0000">╔══</span><span style="color:#00ff00">██</span><span style="color:#ff0000">╗</span><span style="color:#ffff00">██</span><span style="color:#ff0000">╔══</span><span style="color:#ffff00">██</span><span style="color:#ff0000">╗</span><span style="color:#800080">╚██</span><span style="color:#ff0000">╗</span><span style="color:#800080">██</span><span style="color:#ff0000">╔╝</span>  <span style="color:#0000ff">│</span>
<span style="color:#0000ff">│</span>  <span style="color:#00ffff; font-weight:bold">   ███████</span><span style="color:#ff0000">║</span><span style="color:#00ff00">██████</span><span style="color:#ff0000">╔╝</span><span style="color:#ffff00">███████</span><span style="color:#ff0000">║</span><span style="color:#800080"> ╚███</span><span style="color:#ff0000">╔╝</span>   <span style="color:#0000ff">│</span>
<span style="color:#0000ff">│</span>  <span style="color:#00ffff; font-weight:bold">   ██</span><span style="color:#ff0000">╔══</span><span style="color:#00ffff">██</span><span style="color:#ff0000">║</span><span style="color:#00ff00">██</span><span style="color:#ff0000">╔══</span><span style="color:#00ff00">██</span><span style="color:#ff0000">╗</span><span style="color:#ffff00">██</span><span style="color:#ff0000">╔══</span><span style="color:#ffff00">██</span><span style="color:#ff0000">║</span><span style="color:#800080"> ██</span><span style="color:#ff0000">╔</span><span style="color:#800080">██</span><span style="color:#ff0000">╗</span>   <span style="color:#0000ff">│</span>
<span style="color:#0000ff">│</span>  <span style="color:#00ffff; font-weight:bold">   ██</span><span style="color:#ff0000">║  </span><span style="color:#00ffff">██</span><span style="color:#ff0000">║</span><span style="color:#00ff00">██████</span><span style="color:#ff0000">╔╝</span><span style="color:#ffff00">██</span><span style="color:#ff0000">║  </span><span style="color:#ffff00">██</span><span style="color:#ff0000">║</span><span style="color:#800080">██</span><span style="color:#ff0000">╔╝ </span><span style="color:#800080">██</span><span style="color:#ff0000">╗</span>  <span style="color:#0000ff">│</span>
<span style="color:#0000ff">│</span>  <span style="color:#ff0000">   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝</span>  <span style="color:#0000ff">│</span>
<span style="color:#0000ff">│</span>                                            <span style="color:#0000ff">│</span>
<span style="color:#0000ff">│</span>  <span style="color:#ffa500">&lt;&gt;  Code Statistics Tool  &lt;/&gt;</span>             <span style="color:#0000ff">│</span>
<span style="color:#0000ff">└────────────────────────────────────────────┘</span>

<span style="color:#00ff00">Total text files:</span> 152
<span style="color:#ffff00">Binary/media files (not counted in line total):</span> 23
<span style="color:#00ff00">Total lines of code:</span> 12548
<span style="color:#00ffff">Total characters:</span> 389742
<span style="color:#800080">Estimated tokens (4 chars = 1 token):</span> 97435

<span style="color:#00ff00">Lines, characters, and estimated tokens by file extension:</span>
<span style="color:#0000ff">Extension    Files       Lines       Characters     Est. Tokens</span>
------------------------------------------------------------------------
<span style="color:#0000ff">.tsx</span>            42         5421          178924           44731
<span style="color:#0000ff">.js</span>             24         3102           95842           23960
<span style="color:#0000ff">.css</span>            18         1852           56248           14062
<span style="color:#0000ff">.json</span>           15          958           24368            6092
<span style="color:#0000ff">.md</span>             12          842           19873            4968
...
</pre>

> **Note:** The actual output in your terminal will be colorized as shown above to improve readability.

## Customization

### Default Exclusions

By default, Abax excludes:
- `.git` directory (always excluded)
- `node_modules` directory (optional default)
- `.next` directory (optional default)
- Binary and media files from line/character counts

### Binary File Detection

Abax automatically detects and separately reports on binary/media files with these extensions:
`png`, `jpg`, `jpeg`, `gif`, `ico`, `svg`, `mp4`, `mp3`, `wav`, `pdf`, `ttf`, `woff`, `woff2`, `eot`, `DS_Store`, `tsbuildinfo`

### Token Estimation

The default token estimation uses a ratio of 4 characters = 1 token, which is a general approximation. For more accurate estimations specific to certain models, you can customize this ratio when prompted.

## Notes

- Token estimation is approximate and may vary compared to actual tokenization by language models
- The script performance depends on the size of your codebase; large repositories may take longer to process
- The `.git` directory is always excluded as it contains binary files and repository metadata

## License

[MIT License](LICENSE)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. 