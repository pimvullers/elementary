# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_6,2_7} )
VALA_MIN_API_VERSION=0.26
VALA_USE_DEPEND=vapigen

inherit vala autotools python-r1 bzr

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
	>=x11-libs/libwnck-3.4.7:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	${PYTHON_DEPS}
	dev-libs/libxml2[python]
	dev-libs/libxslt[python]
	doc? ( dev-util/gtk-doc )
	introspection? ( dev-libs/gobject-introspection )
	virtual/pkgconfig"

src_prepare() {
	sed -i 's/-Werror//' configure.ac
	sed -i 's/tests//' Makefile.am

	eautoreconf

	vala_src_prepare

	default
}

src_configure() {
	python_setup
	
	econf \
		--disable-gtktest \
		--disable-webapps \
		$(use_enable doc gtk-doc) \ 
		$(use_enable introspection) \
		VALA_API_GEN="${VAPIGEN}"
}
