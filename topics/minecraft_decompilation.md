# Minecraft decompilation

The Forge Community Wiki has an excellent coverage of the background of mappings
and deobfuscation in the [Toolchain](https://forge.gemwire.uk/wiki/Toolchain)
page. [phase/MinecraftMappings](https://github.com/phase/MinecraftMappings) and
[MinecraftDecompiler](https://github.com/MaxPixelStudios/MinecraftDecompiler)
have good cross-mapping coverage. Vineflower has an excellent [architecture](https://github.com/Vineflower/vineflower/blob/master/ARCHITECTURE.md)
document.

## Mappings

- Feather (1.3-1.13.2): Supported by linkie-core.
- Intermediary
- Legacy Yarn (1.3-1.13.2): Supported by linkie-core.
- MCP (ModCoderPack) (1.8+): Supported by SuperSrg as `mcp` and by linkie-core.
- Mojang (1.14.4+): Supported by linkie-core.
- [Parchment](https://parchmentmc.org/): Based on Mojang's mappings.
- Plasma (Beta 1.7.3): Supported by linkie-core.
- [Quilt Mappings](https://github.com/QuiltMC/quilt-mappings): 1.17+
- [Quilt hashed mappings](https://github.com/QuiltMC/mappings-hasher): Creates a
  hashed version of a mapping to avoid license issues and provide package rename
  stability.
- [Spigot](https://hub.spigotmc.org/stash/projects/SPIGOT/repos/builddata/browse):
  Spigot's deobfuscation mappings. According to SuperSrg, they're changed
  infrequently to avoid breakage with plugins and are significantly lower
  quality than MCP mappings as most member names are left obfuscated.
  Supported by SuperSrg as `spigot`.
- SRG (Searge's Retro Guard): Supported by SuperSrg as `srg`.
- Yarn (1.14+): Supported by linkie-core.
- Yarrn (Infdev 20100618): Supported by linkie-core.

### Mappings tools

- Fabric Loom [[docs](https://fabricmc.net/wiki/documentation:fabric_loom)]
  - [Quilt Loom](https://github.com/QuiltMC/quilt-loom): Plugin to simplify use
    of Quilt Mappings
- [SuperSrg](https://github.com/Techcable/SuperSrg): SRG mappings. Supports
  `srg`, `mcp`, `spigot`, and `obf`.
- [DecompilerMC](https://github.com/hube12/DecompilerMC): Converts Mojang
  mappings from Proguard format to TSRG format
- [MCPConfig](https://github.com/MinecraftForge/MCPConfig): Public-facing repo
  for MCP SRG mappings
- [phase/MinecraftMappings](https://github.com/phase/MinecraftMappings): Creates
  transitive mappings. Supports SRG, CSRG, TSRG, Tiny, and JSON formats.

### Resources

- [Fabric mappings tutorial](https://fabricmc.net/wiki/tutorial:mappings)
- [Obfuscation map](https://minecraft.wiki/w/Obfuscation_map) on the Minecraft
  wiki
- [Minecraft Decompilation Guide](https://blog.bithole.dev/blogposts/decompiling-minecraft/)
  by Adrian Zhang (2022)

## Deobfuscators

- [BON](https://archive.softwareheritage.org/browse/origin/directory/?origin_url=https://github.com/immibis/bearded-octo-nemesis&timestamp=2023-07-19T12:36:22Z)
  (Bearded Octo Nemesis) by Immibis (2012–2015)
  - [BON2](https://github.com/tterrag1098/BON2) (2014–2019): Rewrite of BON for
    ForgeGradle.
    - [BON3](https://github.com/NahliZayd/BON3) (2023): Rewrite using Linkie.
- [Deobfuscator3000](https://github.com/SimplyProgrammer/Minecraft-Deobfuscator3000)
  (2020–2021): Allows selecting your own mappings. Closed source JAR.
- Cuchaz [Enigma](https://archive.softwareheritage.org/browse/origin/directory/?origin_url=https://bitbucket.org/cuchaz/enigma)
  (2014–2015)
  [[site](https://www.cuchazinteractive.com/minecraft/enigma/)] [[forum](https://www.planetminecraft.com/mod/enigma-minecraft-deobfuscation-tool/)]
  - Quilt [Enigma](https://github.com/QuiltMC/enigma) (2016–2024): Fork of
    Cuchaz's Enigma with continued history. Supports Vineflower, Procyon, and
    Fabric CFR.
- [Linkie](https://linkie.shedaniel.dev/) [[core](https://github.com/linkie/linkie-core)]:
- [MinecraftDecompiler](https://github.com/MaxPixelStudios/MinecraftDecompiler):
  - Supports these mappings (I assume it lists mapping file formats and projects
    using it):
    - Proguard (official)
    - SRG
    - CSRG (Bukkit, Spigot, Paper)
    - TSRG (SRG 1.13+)
    - TSRG v2 (SRG 1.16.5+)
    - Tiny (Intermediary, Yarn)
  - Supports CFR, FernFlower, ForgeFlower, or any other decompiler

- SpecialSource: remaps the client jar in TSRG format

## Decompilers

- [CFR](https://github.com/leibnitz27/cfr): code decompiler
  - [Fabric CFR](https://github.com/fabricmc/cfr)
- Fernflower: asset and code decompiler
  - [Vineflower](https://github.com/Vineflower/vineflower): fork of Fernflower
- [Procyon Java Decompiler](https://github.com/mstrobel/procyon)
- [JD-GUI](https://github.com/java-decompiler/jd-gui): Java decompiler GUI
