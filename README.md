<div align="center">
    <img src="resources/branding/app_icon/raw.png"
        title="Helium" alt="Helium logo" width="120" />
    <h1>Helium Nix Flake (Custom Fork)</h1>
    <p>
        The Chromium-based web browser made for people, with love.
        <br>
        Privacy-first with unbiased ad-blocking. No bloat and no noise.
    </p>
    <a href="https://helium.computer/">
        helium.computer
    </a>
</div>

> [!WARNING]
> **🚀 Experimental Personal Fork!**
> This repository is an experimental, standalone Nix flake for a custom fork of the Helium browser. It explicitly modifies the original project to re-enable underlying Google integrations like **Google Sync, Google Password Manager/Passkeys, and Google Accounts**.
> 
> **Anyone is free to use this, but it is provided AS IS. I am not accountable for any breakages, bugs, security issues, or anything else that might happen.**

This flake builds the browser natively from source using the official `nixpkgs` Chromium builder infrastructure combined with Helium's custom patches, bypassing the need for binary downloads.

## Flake Usage

### Run directly
You can run this custom Helium browser directly without installing it (**Note:** This will compile Chromium from source on the first run, which will take several hours):

```bash
nix run github:gaurav2361/helium
```

### Integrating into NixOS or Home Manager
For typical modular dotfiles setups (using NixOS, nix-darwin, or Home Manager), you will first define this repository as an `input` in your main `flake.nix`:

```nix
inputs = {
  # ... your other inputs ...
  helium = {
    url = "github:gaurav2361/helium";
    inputs.nixpkgs.follows = "nixpkgs";
  };
};
```

Then, ensure your `inputs` are being passed through to your configuration modules (using `specialArgs` in NixOS/Darwin or `extraSpecialArgs` in Home Manager). 

Once passed through, you can add it directly to your packages list in any of your module files (for example, in your `home.nix` or system `configuration.nix`):

```nix
{ pkgs, inputs, ... }:

{
  environment.systemPackages = [ # or home.packages = [
    # ... your other packages ...
    inputs.helium.packages.\${pkgs.system}.default
  ];
}
```

## Development
To build the package locally using the local patchset:

```bash
nix build .
```
The compiled browser binary will be available at `./result/bin/chromium`.

*Note: This source-build configuration is heavily tested on Linux. Compilation on Darwin (macOS) via Nix is theoretically supported by the flake, but usually requires additional macOS SDK framework configurations to successfully compile Chromium from scratch.*

---


## Downloads
> [!NOTE]
> Helium is currently in beta, so unexpected issues may occur.
> Please report them if they haven't already been reported.

The easiest way to download Helium is [helium.computer](https://helium.computer/).
It'll pick a compatible binary for your platform automatically.

The same releases can also be downloaded from source on GitHub:

- [Latest macOS release](https://github.com/imputnet/helium-macos/releases/latest)
- [Latest Linux release](https://github.com/imputnet/helium-linux/releases/latest)
- [Latest Windows release](https://github.com/imputnet/helium-windows/releases/latest)

## Helium repos
All Helium packaging, tooling, services, and components are open source
and published on GitHub.

### Platform packaging and tooling
- [Helium for macOS](https://github.com/imputnet/helium-macos)
- [Helium for Linux](https://github.com/imputnet/helium-linux)
- [Helium for Windows](https://github.com/imputnet/helium-windows)

### Web services and Helium components
- [Helium services](https://github.com/imputnet/helium-services)
- [Helium onboarding](https://github.com/imputnet/helium-onboarding)
- [Helium fork of uBlock Origin](https://github.com/imputnet/uBlock)

## Development
macOS is our primary development platform, so it's the recommended
development environment for community contributions.

Linux packaging includes a similar development script, so the same guide
can be applied there too.

[> See development docs in macOS repo](https://github.com/imputnet/helium-macos/blob/main/docs/building.md#development-build-and-environment)

## Contributing
Before contributing to Helium, please read the guidelines in
[CONTRIBUTING.md](CONTRIBUTING.md).

## Credits

### The Chromium project
[The Chromium Project](https://www.chromium.org/) is at the core of Helium,
making it possible in the first place.

### ungoogled-chromium
This repo is based on [ungoogled-chromium](https://github.com/ungoogled-software/ungoogled-chromium),
but heavily modified for Helium. Special thanks to everyone behind ungoogled-chromium,
they made working with Chromium way easier.

### Other Chromium browsers

Helium includes some patches from other open source Chromium browsers:

- [Inox patchset](https://github.com/gcarq/inox-patchset)
- [Debian](https://tracker.debian.org/pkg/chromium-browser)
- [Bromite](https://github.com/bromite/bromite)
- [Iridium Browser](https://iridiumbrowser.de/)
- [Brave](https://github.com/brave/brave-core)

All patches are sorted by vendor in the [patches](patches/) directory of this repo.

## License
All code, patches, modified portions of imported code or patches, and
any other content that is unique to Helium and not imported from other
repositories is licensed under GPL-3.0. See [LICENSE](LICENSE).

Any content imported from other projects retains its original license (for
example, any original unmodified code imported from ungoogled-chromium remains
licensed under their [BSD 3-Clause license](LICENSE.ungoogled_chromium)).
