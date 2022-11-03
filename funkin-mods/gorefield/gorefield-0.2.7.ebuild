# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# This mod is based on Psych Engine and requires Psych dependencies.
# Please refer to Psych's compilation instructions.
EAPI=8

DESCRIPTION="Hi, Jon."

HOMEPAGE="https://github.com/JoseXD2/FNF-Vs-Gorefield"

SRC_URI="https://github.com/MagelessMayhem/gorefield/archive/refs/tags/v0.2.7.tar.gz"

S="${WORKDIR}/gorefield-0.2.7"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND="
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
	keepdir "/usr/share/games/FNF-Gorefield"
	insinto "/usr/share/games/FNF-Gorefield"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "You can find the mod in /usr/share/games."
}