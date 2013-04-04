# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16
VALA_USE_DEPEND=vapigen

inherit vala autotools-utils bzr

DESCRIPTION="BAMF Application Matching Framework"
HOMEPAGE="https://launchpad.net/bamf"
EBZR_REPO_URI="lp:bamf"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+introspection doc static-libs"

RDEPEND="
	dev-libs/dbus-glib
	dev-util/gdbus-codegen
	dev-libs/glib:2
	gnome-base/libgtop:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libwnck:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	doc? ( dev-util/gtk-doc )
	introspection? ( dev-libs/gobject-introspection )
	virtual/pkgconfig"

AUTOTOOLS_AUTORECONF=yes
DOCS=(AUTHORS COPYING COPYING.LGPL COPYING.LGPL-2.1 ChangeLog NEWS README TODO)

src_prepare() {
	autotools-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local myeconfargs=(
		--disable-gtktest
		--disable-webapps
		$(use_enable doc gtk-doc)
		$(use_enable introspection)
		VALA_API_GEN="${VAPIGEN}"
	)

	autotools-utils_src_configure
}

