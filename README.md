# What is NeoVim?
Neovim is a highly modular keyboard-based code editor. Unlike other code editors that modify their contents through GUI, Neovim is modified through refactoring text-based plugins.

![Preview of my May2k25 setup solving rustlings qns](./illustrations/screenshot.png)

I do not deserve to take all the credit. This was a clone and modification of the nvim setup by [Arfan Zubi Github](https://github.com/3rfaan), [Arfan Zubi YT](https://youtube.com/@zubiarfan?si=03t-IIL6_Ows-gWB).

This is the new configuration of NeoVim for power users of Rust, Python, Solana(Even though I have not yet configured Solana settings yet as per May2025).

It is loaded with auto completion features, LSP support, beautiful UI ...

# What is my backstory?
I started my programming journey way back in the pandemic(2k20). There was nothing else to do during that time.
<br>
TV got tired of being watched, sleeping got tired of being slept, rain got tired of falling and time got tired of being wasted.
<br>
<br>
I switched hobbies quite often (as everyone did) and then I landed on programming for the first time. It was [programming in Python btw by Mosh Hamedani](https://youtu.be/_uQrJ0TkZlc?si=bGw1jm6-_uUFc9-n).
Back then, it was fire😍. I felt like I had some kind of super power, of which "yes I did".
I interacted with Tuples, Dictionaries, Lists, Virtual Environments, Errors, Loops and it was fun to the logical brain.
<br>
<br>
The more that I keep writing code, I realize that "Programming is formalised problem-solving." There is alot that comes with it, but once you tinker correctly, it is fun.
<br>
<br>
Since then, I had used only VS-Code for literally everything code. Nvim users, do not get me wrong, VS-Code is great, it is superb, very stable, large community support and all the extra goddies that come with it. But after a while of coding, I discovered linux🐧 and made the switch from Windows. This came with some baggage of ricing my Linux setup.
<br>
<br>
Since most of what I do in my Linux is code-related, I thought to myself, "Why can't I code in the terminal?🤔" and this is when I came upon NeoVim.
Since then I hardly look back to VS-Code.
<br>
Do not get me wrong, VS-Code is good, but I feel more like a super-user.
<br>
<br>
I love Neovim because:
- There is a no mouse-setup, meaning I continue to work on my code without having to lift my wrists once comfortable🤤.
- I am working purely in the Terminal.
- It is highly modular. Anything and everything can be tinkered to your preference.
- In case my Desktop Environment crashes (at times), the most important workspace on my machine(NeoVim) remains solid💪.
- Sharing is too easy.
- It is fast.
- Lua.
- My classmates all fear me💅.
- I have gained greater understanding for what is under the hood. Stuff like LSPs, keybindings, auto completions, formatters.

It takes time to get there, but once you do, you have full permission to brag. 😎🤏



# Requirements:
- NVIM v0.11.0
- Use a Nerd Font. I use [JetBrains Mono](https://www.jetbrains.com/lp/mono/#).

#  Features May2k25.
- File Explorer on the right.
  It is a better option because it gives me adequate space to work on my code, besides no one really writes code that fills up the right spaces, so why not use it🤷.
- Uses the "*[Github Dark theme](https://github.com/projekt0n/github-nvim-theme)*" colour-scheme with a transparent background. This feature is also useful if the terminal that is being used is also set to have a transparent background.
  
  *Github Dark* just looks so beautiful 🤩 in my opinion, especially for Rust, C and C++ code.
  
  Multiple other colour-schemes come included:
  - [catpuccin](https://github.com/catppuccin/nvim)
  - [molokai](https://github.com/UtkarshVerma/molokai.nvim)
  - [horizon](https://github.com/akinsho/horizon.nvim)
  - [darcula solid](https://github.com/santos-gabriel-dario/darcula-solid.nvim)    
- Auto Completion using [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) which has been set for configuration for Rust, Python, Solana languages.
- Excellent LSP support.
- Dense Plugin system.
- Customizable and key bindings.
- Uses [snacks.nvim](https://github.com/folke/snacks.nvim) for additional functionality with minimal plugin configuration.
- Phenomenal status bar.
- Git signs to visualise the changes in your code.
 
---

# How to install
## 1. Linux Users 🐧
No matter the distro, go to your terminal and type:
```bash
cd ~/.config && git clone https://github.com/pisgahk/nvim.git && rm -rf .git && cd nvim && nvim .
```
It installs all the required tools and plugins that will get you up and running in no time. 
## 2. Windows users 🪟
(As per now I have no idea) though i recommend that you install WSL and then continue from there.
I found these sources extremely helpful(esp the first):
- [Andres Vidoza on YT](https://www.youtube.com/watch?v=mfemGt0syqo&t=274s)
- [medium.com](https://medium.com/@liu-qilong/a-complete-guide-to-setup-wsl-windows-subsystem-for-linux-4547e88b6cdb)
## 2. Mac users 🍏
(Never used mac ever, though i think that it is the same procedure. Just `git clone` the repo in your `.config` file.)

