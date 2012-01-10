# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils bzr

DESCRIPTION="BAMF Application Matching Framework"
HOMEPAGE="https://launchpad.net/bamf"
EBZR_REPO_URI="lp:bamf"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+introspection doc static-libs"

RDEPEND="
	>=dev-libs/dbus-glib-0.76
	>=dev-libs/glib-2.16.0:2
	gnome-base/libgtop:2
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libwnck:1"
DEPEND="${RDEPEND}
	dev-util/gtk-doc
	introspection? ( dev-libs/gobject-introspection )
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=(AUTHORS COPYING COPYING.LGPL COPYING.LGPL-2.1 ChangeLog NEWS README TODO)
}

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh
}

src_configure() {
	local myeconfargs=(
		--disable-gtktest
		--with-gtk=2
		$(use_enable introspection)
	)

	autotools-utils_src_configure
}

