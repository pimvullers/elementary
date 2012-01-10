# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils cmake-utils git

DESCRIPTION="OpenGL window and compositing manager"
HOMEPAGE="http://www.compiz.org/"
EGIT_REPO_URI="git://anongit.compiz-fusion.org/${PN}/core"

LICENSE="GPL-2 LGPL-2.1 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gconf glib gnome gtk kde +svg"

CDEPEND="
	dev-cpp/glibmm
	dev-libs/glib:2
	dev-libs/libxml2
	dev-libs/libxslt
	media-libs/libpng
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXinerama
	x11-libs/libICE
	x11-libs/libSM
	>=media-libs/mesa-6.5.1-r1
	>=x11-base/xorg-server-1.1.1-r1
	!x11-libs/compiz-bcop
	>=x11-libs/startup-notification-0.7
	|| (
		gconf? ( gnome-base/gconf )
		glib? ( dev-libs/glib:2 )
		x11-libs/libcompizconfig
	)
	gtk? (
		>=x11-libs/gtk+-2.8.0
		x11-libs/libwnck
		x11-libs/pango
		gnome? (
			gnome-base/gnome-desktop
			x11-wm/metacity
		)
	)
	kde? (
		|| (
			>=kde-base/kwin-4.2.0
			kde-base/kwin:live
		)
	)
	svg? (
		>=gnome-base/librsvg-2.14.0:2
		>=x11-libs/cairo-1.0
	)"
RDEPEND="${CDEPEND}
	x11-apps/mesa-progs
	x11-apps/xvinfo"
DEPEND="${CDEPEND}
	dev-libs/boost
	dev-util/pkgconfig
	x11-proto/damageproto
	x11-proto/xineramaproto"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.9.5.92-cmake-gsettings-compile.patch"
	epatch "${FILESDIR}/${PN}-desktop-gnome-or-not.patch"
}

src_configure() {
	local mycmakeargs=(
		"$(cmake-utils_use_use gconf GCONF)"
		"$(cmake-utils_use_use gnome GNOME)"
		"$(cmake-utils_use_use gtk GTK)"
		"$(cmake-utils_use_use kde KDE4)"
		"-DCOMPIZ_DISABLE_SCHEMAS_INSTALL=ON"
		"-DCOMPIZ_INSTALL_GCONF_SCHEMA_DIR=/etc/gconf/schemas"
		"-DCOMPIZ_PACKAGING_ENABLED=ON"
		"-DCOMPIZ_DESTDIR=${D}"
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile -j1
}

src_install() {
	pushd ${CMAKE_BUILD_DIR}
	dodir /usr/share/cmake/Modules
	emake findcompiz_install || die "Failed to install FindCompiz cmake module"
	emake install || die "Failed to install"
	popd ${CMAKE_BUILD_DIR}
}

pkg_preinst() {
	use gconf || rm -rf "${ED}/etc"
	use gconf && gnome2_gconf_savelist
}

pkg_postinst() {
	use gconf && gnome2_gconf_install
}

pkg_prerm() {
	use gconf && gnome2_gconf_uninstall
}

