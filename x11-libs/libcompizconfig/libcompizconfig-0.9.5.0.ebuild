# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils cmake-utils

DESCRIPTION="Compiz Configuration System"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gconf glib"

CDEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	dev-libs/protobuf
	=x11-wm/compiz-${PV}*"
RDEPEND="${CDEPEND}
	gconf? ( =x11-libs/compizconfig-backend-gconf-${PV}* )
	glib? ( =x11-libs/compizconfig-backend-gsettings-${PV}* )"
DEPEND="${CDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	DOCS="AUTHORS COPYING ChangeLog LICENSE.gpl LICENSE.lgpl NEWS README TODO VERSION"
}

src_prepare() {
	epatch "${FILESDIR}/${P}-config-install.patch"
}

src_configure() {
	mycmakeargs=(
		"-DCOMPIZ_DISABLE_SCHEMAS_INSTALL=ON"
		"-DCOMPIZ_INSTALL_GCONF_SCHEMA_DIR=/etc/gconf/schemas"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	# Install the FindCompizConfig.cmake file
	insinto /usr/share/cmake/Modules
	doins cmake/FindCompizConfig.cmake
}

pkg_preinst() {
	use gconf && gnome2_gconf_savelist
}

pkg_postinst() {
	use gconf && gnome2_gconf_install
}

pkg_postrm() {
	use gconf && gnome2_gconf_uninstall
}

