# Homelab & Game Server Documentation

Welcome to the public repository for my Homelab and Game Server configurations. This project is a live, synchronized collection of data used to power the Homelab and Guides section of [trentbauer.com](https://trentbauer.com).

## Educational Focus & Community Intent
This repository has been structured with an educational focus to support the self-hosting community. By providing a transparent look at a functional production environment, this resource aims to offer real-world examples of:

* **Infrastructure as Code:** Utilizing modular Docker Compose files for scalable service deployment.
* **Security Best Practices:** Implementing CrowdSec and Cloudflare bouncers to protect public-facing services from malicious traffic.
* **Game Server Management:** Providing deep-dive configuration tuning for panels like Pelican and Pterodactyl, along with specific game optimizations for titles such as *Insurgency: Sandstorm*.
* **Automated Documentation Lifecycle:** Using GitHub Actions to ensure configurations and guides remain synchronized and accurate.

## Repository Structure
* **`.github/`**: Contains automation workflows for repository synchronization and specialized issue templates for documentation corrections.
* **`docker-compose/`**: A library of deployment files for media management (Plex, Arr suite), monitoring (Beszel, Uptime Kuma), and various utility tools.
* **`crowdsec/`**: Security configurations for local firewall and Cloudflare-level threat mitigation.
* **`game-server-configs/`**: Performance and gameplay optimizations, including `Engine.ini` and `Game.ini` settings for community servers.

## Community & Support
This project is an open-source educational resource. While primarily for documentation, minimal community support is available through:
* **Discord**: Join the conversation at [A Gamers Grind](https://discord.agamersgrind.com).
* **Website**: Technical guides and deep dives at [trentbauer.com](https://trentbauer.com).

## Contributions
If you find an error or wish to suggest an improvement to our educational materials:
1.  **Documentation Corrections:** Please use the [Documentation Change template](https://github.com/trentnbauer/HomelabPublic/blob/master/.github/ISSUE_TEMPLATE/gitbook_change.yaml) to suggest specific fixes for GitBook pages.
2.  **Technical Issues:** Use the [Bug Report template](https://github.com/trentnbauer/HomelabPublic/blob/master/.github/ISSUE_TEMPLATE/bug_report.yaml) to report issues with specific app configurations.

---
*Maintained by [@trentnbauer](https://github.com/trentnbauer)*
