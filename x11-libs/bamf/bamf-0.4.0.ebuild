# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.16
VALA_USE_DEPEND=vapigen

inherit vala autotools-utils python

DESCRIPTION="BAMF Application Matching Framework"
HOMEPAGE="https://launchpad.net/bamf"
SRC_URI="http://launchpad.net/${PN}/0.4/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection doc static-libs"

PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"

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

DOCS=(AUTHORS COPYING COPYING.LGPL ChangeLog NEWS README TODO)

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	sed -i 's/-Werror//' configure

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

