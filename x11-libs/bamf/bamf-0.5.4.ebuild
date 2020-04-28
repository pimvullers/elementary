# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{2_6,2_7} )
VALA_MIN_API_VERSION=0.26
VALA_USE_DEPEND=vapigen

inherit python-r1 vala

DESCRIPTION="BAMF Application Matching Framework"
HOMEPAGE="https://launchpad.net/bamf"
SRC_URI="https://launchpad.net/${PN}/0.5/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="gtk-doc +introspection static-libs"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	dev-util/gdbus-codegen
	gnome-base/libgtop:2
	x11-libs/gtk+:3
	x11-libs/libX11
	>=x11-libs/libwnck-3.4.7:3
	x11-libs/startup-notification
"

DEPEND="${RDEPEND}
	$(vala_depend)
	${PYTHON_DEPS}
	dev-libs/libxml2[python]
	dev-libs/libxslt[python]
	gtk-doc? ( dev-util/gtk-doc )
	introspection? ( dev-libs/gobject-introspection )
	virtual/pkgconfig
"

src_prepare() {
	sed -i 's/-Werror//' configure
	vala_src_prepare
	default
}

src_configure() {
	python_setup

	VALA_API_GEN="${VAPIGEN}" \
	econf \
		--disable-gtktest \
		$(use_enable gtk-doc) \
		$(use_enable introspection)
}
