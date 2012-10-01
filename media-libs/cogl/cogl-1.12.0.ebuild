# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
CLUTTER_LA_PUNT="yes"

# Inherit gnome2 after clutter to download sources from gnome.org
inherit eutils clutter gnome2 multilib virtualx
if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

DESCRIPTION="A library for using 3D graphics hardware to draw pretty pictures"
HOMEPAGE="http://www.clutter-project.org/"

LICENSE="LGPL-2.1+ FDL-1.1+"
SLOT="1.0"
IUSE="doc examples +introspection +opengl gles2 +pango"
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~x86"
fi

# XXX: need uprof for optional profiling support
COMMON_DEPEND=">=dev-libs/glib-2.28.0:2
	x11-libs/cairo
	>=x11-libs/gdk-pixbuf-2:2
	x11-libs/libdrm
	x11-libs/libX11
	>=x11-libs/libXcomposite-0.4
	x11-libs/libXdamage
	x11-libs/libXext
	>=x11-libs/libXfixes-3
	virtual/glu
	virtual/opengl
	gles2? ( media-libs/mesa[gles2] )

	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	pango? ( >=x11-libs/pango-1.20.0[introspection?] )"
# before clutter-1.7, cogl was part of clutter
RDEPEND="${COMMON_DEPEND}
	!<media-libs/clutter-1.7"
DEPEND="${COMMON_DEPEND}
	sys-devel/gettext
	virtual/pkgconfig
	doc? ( app-text/docbook-xml-dtd:4.1.2
		>=dev-util/gtk-doc-1.13 )
	test? (	app-admin/eselect-opengl
		media-libs/mesa[classic] )"
# Need classic mesa swrast for tests, llvmpipe causes a test failure

pkg_setup() {
	DOCS="NEWS README"
	EXAMPLES="examples/{*.c,*.jpg}"
	# XXX: think about kms-egl, gles, quartz, sdl, wayland
	G2CONF="${G2CONF}
		--disable-examples-install
		--disable-profile
		--disable-maintainer-flags
		--enable-cairo
		--enable-gdk-pixbuf
		$(use_enable opengl glx)
		$(use_enable opengl gl)
		$(use_enable gles2)
		$(use_enable gles2 cogl-gles2)
		$(use_enable gles2 xlib-egl-platform)
		--enable-glib
		--enable-deprecated
		$(use_enable introspection)
		$(use_enable pango cogl-pango)"
	use gles2 && G2CONF="${G2CONF} --with-default-driver=gles2"
}

src_prepare() {
	# https://bugzilla.gnome.org/show_bug.cgi?id=684731
	epatch "${FILESDIR}/${PN}-1.12.0-fix-experimental-doc-build.patch"
	gnome2_src_prepare
}

src_test() {
	# Use swrast for tests, llvmpipe is incomplete and "test_sub_texture" fails
	# NOTE: recheck if this is needed after every mesa bump
	if [[ "$(eselect opengl show)" != "xorg-x11" ]]; then
		ewarn "Skipping tests because a binary OpenGL library is enabled. To"
		ewarn "run tests for ${PN}, you need to enable the Mesa library:"
		ewarn "# eselect opengl set xorg-x11"
		return
	fi
	LIBGL_DRIVERS_PATH="${EROOT}/usr/$(get_libdir)/mesa" Xemake check
}

src_install() {
	clutter_src_install

	# Remove silly examples-data directory
	rm -rvf "${ED}/usr/share/cogl/examples-data/" || die
}
