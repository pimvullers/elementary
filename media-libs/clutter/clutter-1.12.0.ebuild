# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/clutter/clutter-1.10.8.ebuild,v 1.2 2012/07/14 13:19:30 blueness Exp $

EAPI="4"
CLUTTER_LA_PUNT="yes"
WANT_AUTOMAKE="1.11"

# Inherit gnome2 after clutter to download sources from gnome.org
# since clutter-project.org doesn't provide .xz tarballs
inherit clutter gnome2 virtualx
if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

DESCRIPTION="Clutter is a library for creating graphical user interfaces"

LICENSE="LGPL-2.1+ FDL-1.1+"
SLOT="1.0"
IUSE="debug doc gtk +introspection test" # evdev tslib
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~x86"
fi

# NOTE: glx flavour uses libdrm + >=mesa-7.3
# XXX: uprof needed for profiling
# >=libX11-1.3.1 needed for X Generic Event support
RDEPEND="
	>=dev-libs/glib-2.31.19:2
	>=dev-libs/atk-2.5.3[introspection?]
	>=dev-libs/json-glib-0.12[introspection?]
	>=media-libs/cogl-1.9.6:1.0[introspection?,pango]
	media-libs/fontconfig
	>=x11-libs/cairo-1.10[glib]
	>=x11-libs/pango-1.30[introspection?]

	virtual/opengl
	x11-libs/libdrm
	>=x11-libs/libX11-1.3.1
	x11-libs/libXext
	x11-libs/libXdamage
	x11-proto/inputproto
	>=x11-libs/libXi-1.3
	>=x11-libs/libXfixes-3
	>=x11-libs/libXcomposite-0.4

	gtk? ( >=x11-libs/gtk+-3.3.18:3 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.6 )"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.15
	virtual/pkgconfig
	>=sys-devel/gettext-0.17
	doc? (
		>=dev-util/gtk-doc-1.15
		>=app-text/docbook-sgml-utils-0.6.14[jadetex]
		dev-libs/libxslt )
	test? ( x11-libs/gdk-pixbuf )"

# Tests fail with both swrast and llvmpipe
# They pass under r600g, so the bug is in mesa
RESTRICT="test"

pkg_setup() {
	DOCS="README NEWS ChangeLog*"

	# XXX: Conformance test suite (and clutter itself) does not work under Xvfb
	# XXX: Profiling, coverage disabled for now
	# XXX: What about cex100/egl/osx/wayland/win32 backends?
	# XXX: evdev/tslib input seem to be experimental?
	myconf="--enable-debug=minimum"
	use debug && myconf="--enable-debug=yes"
	G2CONF="${G2CONF} ${myconf}
		--enable-xinput
		--enable-x11-backend=yes
		--disable-profile
		--disable-maintainer-flags
		--disable-gcov
		--disable-cex100-backend
		--disable-egl-backend
		--disable-quartz-backend
		--disable-wayland-backend
		--disable-win32-backend
		--disable-tslib-input
		--disable-evdev-input
		$(use_enable gtk gdk-backend)
		$(use_enable introspection)
		$(use_enable doc docs)
		$(use_enable test conformance)
		$(use_enable test gdk-pixbuf)"
}

src_prepare() {
	gnome2_src_prepare

	# We only need conformance tests, the rest are useless for us
	sed -e 's/^\(SUBDIRS =\).*/\1/g' \
		-i tests/Makefile.am || die "am tests sed failed"
	sed -e 's/^\(SUBDIRS =\)[^\]*/\1/g' \
		-i tests/Makefile.in || die "in tests sed failed"
}

src_test() {
	# Run only the conformance tests
	# The perf tests are useless because we run under sw rendering
	cd tests/
	Xemake test conform
}

src_install() {
	clutter_src_install
}
