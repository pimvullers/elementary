# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils cmake-utils

DESCRIPTION="The terminal of the 21st century"
HOMEPAGE="https://launchpad.net/pantheon-terminal"
SRC_URI="https://launchpad.net/${PN}/0.x/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="
	x11-libs/granite
	x11-libs/libnotify
	x11-libs/gtk+:3
	x11-libs/vte:2.90"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	nls? ( sys-devel/gettext )
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS README )
}

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_prepare() {
	use nls || sed -i 's/add_subdirectory (po)//' CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.16)"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
