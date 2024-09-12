<div align="center">
    <img src="readme_assets/volcano-logo-github.png" width=500>
    <br>
    <a href="https://apps.apple.com/jp/app/volcano-with-todo/id6657991782">
        <img src="readme_assets/download-on-the-app-store.png" width=150>
        <!-- TODO draw illustration of Download on the App Store -->
    </a>
        <br>
        <br>
    <a href="https://github.com/aoiorio/Volcano/releases/tag/v1.1.0">
        <img src="https://img.shields.io/badge/Volcano_version-1.1.0-white">
    </a>
    <a href="https://github.com/aoiorio/VolcanoAPI">
        <img src="https://img.shields.io/badge/Volcano_API_version-1.0.0-yellow">
    </a>
    <img src="https://github.com/aoiorio/Volcano/actions/workflows/flutter_lint.yaml/badge.svg">
    <img src="https://img.shields.io/github/commit-activity/m/aoiorio/Volcano">
    <img src="https://img.shields.io/github/license/aoiorio/Volcano">
    <img src="https://img.shields.io/badge/Flutter-3.19.6-74737B?logo=flutter">
    <img src="https://img.shields.io/badge/Dart-3.3.4-BABBC8?logo=dart">
    <img src="https://img.shields.io/badge/architecture-onion_architecture-d9d9d9">
</div>

<br>

<br>

<br>

## ```🌋 {"Contents"}```

### [```{1: "🫣 Overview"}```]()

### [```{2: "🍽️ Methods"}```]()

### [```{3: "🫐 Thoughts"}```]()

<br>

<br>

<br>


# ```{1: "🫣 Overview"}```

<br>

<img src="readme_assets/volcano-app-store-screenshots.png" style="border-radius: 20px">

<br>

## ```🌭 "What is Volcano"```

**Volcano** is a simple TODO app that can recognize your voices and convert them to texts as a **TODO**.
You can tell your TODO to Volcano like you're speaking with someone.

<br>

## ```🧈 "Why"```

I usually write down my TODOs on my note every single day.
<br>
But I perceived that it's pain in the neck and will definitely forget something what I'm going to do today.

So I came up with an application idea to manage my TODOs with more comfortable way.

I thought recognizing my voice can be a powerful feature to remember what I was planning to do.

That's the reason of why Volcano was created.

<br>

## ```🐓 "Persona"```
<img src="readme_assets/volcano-persona.png" style="border-radius: 20px">


<br>

## ```🍈 "Features & Durations"```

<br>

- 📁 "TODO"

    - **Voice Recognizing Feature & Add TODO From Voice Feature** - 2024/06/12 - 06/28

    - **Add From Text Feature** - 2024/06/12 - 06/28

    - **Playing Voice Feature** - 2024/06/28 - 07/6

    - **Mark as accomplished Feature** - 2024/06/28 - 07/6

    - **Delete TODO Feature** - 2024/07/7 - 07/14

    - **Edit TODO Feature** - 2024/07/7 - 07/14

    - **Showing TODO With Each Type Feature** - 2024/06/28 - 07/6

    - **Showing Today's TODO Feature** - 2024/07/3 - 07/8

    - **Showing Month's TODO Feature** - 2024/06/28 - 07/6

    - **Sending Notification every morning Feature (new)** - 2024/08/27 - 08/29

<br>

- 🥕 "User"

    - **Sign In Feature** - 2024/06/02 - 06/11

    - **Sign Up Feature** - 2024/06/02 - 06/11

    - **Sign Out Feature** - 2024/07/14 - 07/22

    - **Deleting User Feature** - 2024/07/14 - 07/22

    - **Edit Username Feature** - 2024/07/14 - 07/22

### 💻 Overall: 2024/05/19 - 2024/08/26 (100 days)

<br>

## ```🫨 "Links"```
- "🦀 Volcano API": [Volcano API](https://github.com/aoiorio/VolcanoAPI)
- "🪡 Slides": [Volcano Slides](https://docs.google.com/presentation/d/1eIEV2Hm08teWd2m_5D9OY7se3-NyqIaro5_hdHCcKiI/edit?usp=sharing)
- "🧳 Requirements Definition Slides": [Volcano Requirements Definition Slides](https://docs.google.com/presentation/d/1VScbl4NEXO8QbhK5rt-C63ebLQKySBvkVg6RB1wOrgI/edit?usp=sharing)

<br>

<br>

<br>

# ```{2: "🍽️ Methods"}```

<br>

## ```📺 "Technologies"```

### 🪟 "Front-End"
<br>

<img src="https://img.shields.io/badge/Dart-3.19.6-d9d9d9?logo=flutter"><img src="https://img.shields.io/badge/Dart-3.3.4-d9d9d9?logo=dart"><img src="https://img.shields.io/badge/architecture-onion_architecture-d9d9d9">

### 🐘 "Back-End"
<img src="https://img.shields.io/badge/Python-3.12.3-blue?logo=python"><img src="https://img.shields.io/badge/FastAPI-0.99.0-blue?logo=fastapi"><img src="https://img.shields.io/badge/architecture-onion_architecture-d9d9d9">

### 🌯 "Infrastructure"
<img src="https://img.shields.io/badge/AWS_Lambda-white?logo=awslambda"><img src="https://img.shields.io/badge/Amazon_API_Gateway-white?logo=amazonapigateway">

### 🫑 "Design"
<a href="https://www.figma.com/design/mdtvg3qX7BxmcpDqgEFeJM/Volcano?node-id=0-1&t=jY2GYAAmbcv06Y3E-1">
    <img src="https://img.shields.io/badge/Figma-gray?logo=figma">
</a>

<br>

## ```📸 "Pictures"```
<br>

| "As an User"| "As a Developer"|
|----|----|
|<img src="readme_assets/method-picture-user.png" width=600>|<img src="readme_assets/method-picture-me.png" width=600>|

<br>

## ```🧠 "ERD"```
<div align="center">
<img src="readme_assets/volcano-erd.png" width=600>
</div>
<br>

<br>

<br>

# ```{3: "🫐 Thoughts"}```

<br>

## ```💎 "My Favorites"```
<br>

###  1. 🐠 **Saving Hex Color Code In Database**
- Reason
    - I wanted to create a great app to recognize types directly through my eyes

- Difficult Points
    - Converting color codes to Flutter's color codes
    - Generating RBG with range for color I like

### 2. 🙃 Displaying Today's TODOs
- Reason
    - When I open Volcano in the morning, I can see what I have to do today and achieve it without forgetting something

- Difficult Points
    - I was torn between splitting the API endpoints of getting Today's TODO and Month's TODO or not (Finally I decided to combine them together)

### 3. 🗂️ Using Onion Architecture
- Reason
    - I usually write spaghetti codes so I was craving for writing clean and updatable codes by myself

- Difficult Points
    - I've started to learn about Onion Architecture without any knowledge of it. So I struggled with how I create folder structure

<br>

## ```🤠 "What I've got"```
<br>

### "I felt like I was working with my teammates even I've developed this by my own"
- I used architecture like I was creating an app with someone
- When I merge my PR to a branch, I always send "LGTM" photo on my issue or PR pages and it seemed like I was reviewed from my boss
- I also tried to separate URLs of Amazon API Gateway such as prod and dev like the actual projects do in companies


<br>

<br>

<a href="https://www.buymeacoffee.com/aoiorio" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

<br>

<br>


```python
{
    "status_code": 500,
    "message": "Thank you."
}
```