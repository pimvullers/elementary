# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/clutter-gst/clutter-gst-2.0.8.ebuild,v 1.3 2013/12/08 19:09:47 pacho Exp $

EAPI="5"
GCONF_DEBUG="yes"
CLUTTER_LA_PUNT="yes"
PYTHON_COMPAT=( python2_{6,7} )

# inherit clutter after gnome2 so that defaults aren't overriden
# inherit gnome.org in the end so we use gnome mirrors and get the xz tarball
inherit gnome2 clutter gnome.org python-any-r1

DESCRIPTION="GStreamer integration library for Clutter"

SLOT="2.0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE="examples +introspection"

# FIXME: Support for gstreamer-basevideo-0.10 (HW decoder support) is automagic
COMMON_DEPEND="
	>=dev-libs/glib-2.20:2
	>=media-libs/clutter-1.6.0:1.0=[introspection?]
	>=media-libs/cogl-1.10:1.0=[introspection?]
	media-libs/gstreamer:1.0[introspection?]
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-base:1.0[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.6.8 )
"
# uses goom from gst-plugins-good
RDEPEND="${COMMON_DEPEND}
	media-libs/gst-plugins-good:1.0
"
DEPEND="${COMMON_DEPEND}
	${PYTHON_DEPS}
	>=dev-util/gtk-doc-am-1.8
	virtual/pkgconfig
"

src_prepare() {
	DOCS="AUTHORS NEWS README"
	EXAMPLES="examples/{*.c,*.png,README}"

	# Make doc parallel installable
	cd "${S}"/doc/reference
	sed -e "s/\(DOC_MODULE.*=\).*/\1${PN}-${SLOT}/" \
		-e "s/\(DOC_MAIN_SGML_FILE.*=\).*/\1${PN}-docs-${SLOT}.sgml/" \
		-i Makefile.am Makefile.in || die
	sed -e "s/\(<book.*name=\"\)clutter-gst/\1${PN}-${SLOT}/" \
		-i html/clutter-gst.devhelp2 || die
	mv clutter-gst-docs{,-${SLOT}}.sgml || die
	mv clutter-gst-overrides{,-${SLOT}}.txt || die
	mv clutter-gst-sections{,-${SLOT}}.txt || die
	mv clutter-gst{,-${SLOT}}.types || die
	mv html/clutter-gst{,-${SLOT}}.devhelp2

	cd "${S}"
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-maintainer-flags \
		$(use_enable introspection)
}

src_compile() {
	# Clutter tries to access dri without userpriv, upstream bug #661873
	# Massive failure of a hack, see bug 360219, bug 360073, bug 363917
	unset DISPLAY
	default
}
