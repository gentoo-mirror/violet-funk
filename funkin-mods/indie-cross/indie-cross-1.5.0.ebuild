# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="FNF mod collaboration between notable Indie characters"

HOMEPAGE="https://github.com/brightfyregit/Indie-Cross-Public"

SRC_URI="https://github.com/MagelessMayhem/Violet-IC/archive/refs/tags/v1.5.0-ic.tar.gz"

S="${WORKDIR}/Violet-IC-1.5.0-ic"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
	gnome-base/gconf
	dev-lang/luajit
        media-sound/pulseaudio
        x11-libs/libX11
        =dev-lang/haxe-9999
"

DEPEND="${RDEPEND}"

src_compile() {
    haxelib setup /var/tmp/portage/.local/share/haxe/lib
    cd ${S}
    haxelib run lime build linux -verbose
}
src_install() {
    keepdir "/usr/share/games/Indie-Cross"
    insinto "/usr/share/games/Indie-Cross"
    doins -r "export/release/linux/bin"
}
pkg_postinst() {
    elog "You can find the mod in /usr/share/games."
    elog
    elog "Indie Cross requires at least 4 GB of"
    elog "system RAM to run smoothly. You may have"
    elog "performance issues if your system doesn't"
    elog "meet this criteria."
    elog
    elog "You may also want to run this command to"
    elog "be able to run the mod:"
    elog
    elog "sudo chown -R <username> /usr/share/games/Indie-Cross"
}