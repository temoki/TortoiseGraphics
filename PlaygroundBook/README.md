# Playground Book

## How to build playground book for iPad

### Sync sources

Sync `TortoiseGraphics` module's sources to `Tortoise.playground`.

```shell
sh ./sync.sh
```

### Check Tortoise.Playground

Open `Tortoise.Playground` by Xcode and test operation.

### Update manifest file

Update `./template/Contents/Manifest.plist` that contains book version, swift version, etc.

### Build playground Book

Build `TortoisePlayground.playgroundbook` with `./template` directory.

```shell
sh ./build.sh
```
