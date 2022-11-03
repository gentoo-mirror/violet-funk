# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Refer to the compilation instructions of FNF to fetch the proper libraries.
# https://github.com/ninjamuffin99/Funkin
EAPI=8

DESCRIPTION="A rhythm game made with HaxeFlixel"
HOMEPAGE="https://ninja-muffin24.itch.io/funkin"
# This tarball contains an hscript fix that allows FNF to compile properly
SRC_URI="
	https://github.com/MagelessMayhem/Funkin/archive/refs/tags/v0.2.7.1.tar.gz
	utau? ( https://github.com/MagelessMayhem/Funkin/releases/download/v0.2.7.1u/utau-covers.tar.gz )
	"

S="${WORKDIR}/Funkin-0.2.7.1"

LICENSE="Apache-2.0"

SLOT="0"

KEYWORDS="~amd64"

IUSE="
	utau
"

RDEPEND="
	media-sound/pulseaudio
	x11-libs/libX11
	=dev-lang/haxe-9999
"

DEPEND="
	${RDEPEND}
"

# Implement a dummy template Haxe file; the game will not compile without it. This is also mentioned in the Funkin compilation instructions.
src_compile() {
	haxelib setup /var/tmp/portage/.local/share/haxe/lib
	if [ -d "${WORKDIR}/assets" ]; then
		cp -r "${WORKDIR}/assets/songs/" "${S}/assets/"
	fi
	cd ${S}
        touch source/APIStuff.hx
        echo "package;
              class APIStuff
              {
                    public static var API:String = \"\";
                    public static var EncKey:String = \"\";
              }
        " | tee -a source/APIStuff.hx
        wait
	haxelib run lime build linux -verbose
	wait

}
src_install() {
	keepdir "/usr/share/games/Funkin"
	insinto "/usr/share/games/Funkin"
	doins -r "export/release/linux/bin"
}
pkg_postinst() {
	elog "FNF has been installed to /usr/share/games/Funkin. You may cd"
	elog "into this directory to run the game."
	elog
	elog "If you want UTAU covers, enable the utau USE flag and"
	elog "remerge this package."
}
