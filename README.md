# 🏓 Deploy Script

stockLogic uses a deploy script, requiring our source code. Using our deploy script allows us to silently update our system without the need for you to restart the setup process.

We do not recommend for you to directly use the source code unless you have to create changes that aren't possible with the built-in plugin system. If you use the source code, you will not get automatic updates & bug fixes to your game.

**Join our** [**Discord**](https://discord.gg/sQxBmkDzr9)**, we plan to release more free, open-sourced products. Furthermore, you can gain support there!**

Get our deploy model [here](https://roblox.com/library/9145770328), and follow setup steps below.

* Move the `Deploy` script to `ServerScriptService`.
* Create a `Folder` called `Items` and put it in `Workspace`.
* Create a `Folder` called `Supplies` and put it in `Workspace`.
* Create a `Folder` called `Tools` and put it in `ServerStorage`.
* Parent the `Tool` called `Restock Tool` to `ServerStorage`, if you wish to change this tool, you can.

The `Items` folder expects "categories", which are folders. **These categories shall match the name of the tool (case sensitive) they point to**, an example is shown below.

Objects inside categories shall be either a `Part`, `Union`, `BasePart`, etc. Make sure these objects don't already have a `ClickDetector` or `ProximityPrompt` inside them, or the system will disable them.

The `Supplies` folder is essentially spawn points where staff members have the abilitiy the get the `Restock Tool` that you made earlier.

The `Tools` folder expects only `Tool` objects, if you do not know how to make tools, please view Roblox documentation [here](https://developer.roblox.com/en-us/articles/intro-to-player-tools).
