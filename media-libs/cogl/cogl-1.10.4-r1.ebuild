# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/cogl/cogl-1.10.4.ebuild,v 1.9 2013/03/27 10:29:01 ago Exp $

EAPI="5"
CLUTTER_LA_PUNT="yes"

# Inherit gnome2 after clutter to download sources from gnome.org
inherit eutils clutter gnome2 multilib virtualx

DESCRIPTION="A library for using 3D graphics hardware to draw pretty pictures"
HOMEPAGE="http://www.clutter-project.org/"

LICENSE="LGPL-2.1+ FDL-1.1+"
SLOT="1.0/9"
IUSE="doc examples +introspection +opengl gles2 +pango"
KEYWORDS="~alpha amd64 ~mips ppc ppc64 x86"

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
	virtual/opengl
	gles2? ( media-libs/mesa[gles2] )

	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	pango? ( >=x11-libs/pango-1.20.0[introspection?] )"
# before clutter-1.7, cogl was part of clutter
RDEPEND="${COMMON_DEPEND}
	!<media-libs/clutter-1.7"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	sys-devel/gettext
	doc? ( app-text/docbook-xml-dtd:4.1.2
		>=dev-util/gtk-doc-1.13 )
	test? (	app-admin/eselect-opengl
		media-libs/mesa[classic] )"
# Need classic mesa swrast for tests, llvmpipe causes a test failure

src_prepare() {
	DOCS="NEWS README"
	EXAMPLES="examples/{*.c,*.jpg}"
	# XXX: think about kms-egl, quartz, sdl, wayland
	G2CONF="${G2CONF}
		--disable-examples-install
		--disable-profile
		--disable-maintainer-flags
		--enable-cairo
		--enable-gdk-pixbuf
		$(use_enable opengl glx)
		$(use_enable opengl gl)
		$(use_enable gles2)
		$(use_enable gles2 xlib-egl-platform)
		--enable-glib
		--enable-deprecated
		$(use_enable introspection)
		$(use_enable pango cogl-pango)
		$(use_enable doc gtk-doc)"
	# Really need --enable-gtk-doc for docs

	# USE=doc build failure; in 1.12.x; bug #436308
	epatch "${FILESDIR}/${PN}-1.10.4-cogl-clipping.xml.patch"
	epatch "${FILESDIR}/${PN}-1.10.4-fix-crash-on-free.patch"
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
