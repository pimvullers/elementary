# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_HAS_SUBMODULES=true

inherit cmake-utils git

DESCRIPTION="Compiz Window Manager Extra Plugins"
HOMEPAGE="http://www.compiz.org/"
EGIT_REPO_URI="git://anongit.compiz.org/compiz/plugins-extra"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gconf nls"

RDEPEND="
	virtual/jpeg
	x11-libs/cairo
	>=gnome-base/librsvg-2.14.0
	=x11-plugins/compiz-plugins-main-${PV}*[gconf?]
	=x11-wm/compiz-${PV}*[gconf?]"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	gconf? ( gnome-base/gconf )
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS="AUTHORS COPYING ChangeLog NEWS VERSION"
}

src_configure() {
	mycmakeargs=(
		"-DCOMPIZ_DISABLE_SCHEMAS_INSTALL=ON"
		"-DCOMPIZ_INSTALL_GCONF_SCHEMA_DIR=/etc/gconf/schemas"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	use gconf || rm -rf "${ED}/etc"
	use gconf && gnome2_gconf_savelist
}

pkg_postinst() {
	use gconf && gnome2_gconf_install
}

pkg_postrm() {
	use gconf && gnome2_gconf_uninstall
}

