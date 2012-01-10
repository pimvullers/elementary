# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils

DESCRIPTION="BAMF Application Matching Framework"
HOMEPAGE="https://launchpad.net/bamf"
#SRC_URI="http://launchpad.net/${PN}/0.2/${PV}/+download/${P}.tar.gz"
SRC_URI="http://launchpad.net/${PN}/0.2/0.2.204/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+introspection doc static-libs"

RDEPEND="dev-libs/dbus-glib
	dev-libs/glib:2
	gnome-base/libgtop:2
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libwnck:1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=(AUTHORS COPYING COPYING.LGPL ChangeLog NEWS README TODO)

src_configure() {
	local myeconfargs=(
		--disable-gtktest
		--with-gtk=2
		$(use_enable doc gtk-doc)
		$(use_enable introspection)
	)
	autotools-utils_src_configure
}

