# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/mutter/mutter-3.10.2.ebuild,v 1.1 2013/12/24 17:49:26 pacho Exp $

EAPI="5"
GCONF_DEBUG="yes"

inherit eutils gnome2

DESCRIPTION="GNOME 3 compositing window manager based on Clutter"
HOMEPAGE="http://git.gnome.org/browse/mutter/"
SRC_URI="${SRC_URI}
	https://launchpad.net/ubuntu/+archive/primary/+files/mutter_3.8.4-0ubuntu2.debian.tar.gz"
#	https://launchpad.net/~ricotz/+archive/testing/+files/mutter_3.11.4%2Bgit20140121.aab354b7-0ubuntu1%7E14.04%7Ericotz0.debian.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
IUSE="+introspection test +ubuntu"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"

COMMON_DEPEND="
	>=x11-libs/pango-1.2[X,introspection?]
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf:2[introspection?]
	>=x11-libs/gtk+-3.9.11:3[X,introspection?]
	>=dev-libs/glib-2.36.0:2
	>=media-libs/clutter-1.14.3:1.0[introspection?]
	>=media-libs/cogl-1.15.6:1.0=[introspection?]
	>=media-libs/libcanberra-0.26[gtk3]
	>=x11-libs/startup-notification-0.7
	>=x11-libs/libXcomposite-0.2
	>=gnome-base/gsettings-desktop-schemas-3.7.3[introspection?]
	gnome-base/gnome-desktop:3=
	>=sys-power/upower-0.99.0

	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender
	>=x11-libs/libXi-1.7

	gnome-extra/zenity

	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-doc-am-1.15
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xproto
	test? ( app-text/docbook-xml-dtd:4.5 )
"
RDEPEND="${COMMON_DEPEND}
	!x11-misc/expocity
"

src_prepare() {
	DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README *.txt doc/*.txt"

	# Ubuntu patches
	if use ubuntu; then
		einfo "Applying patches from Ubuntu:"
		for patch in `cat "${FILESDIR}/${P}-ubuntu-patch-series"`; do
			epatch "${WORKDIR}/debian/patches/${patch}"
		done
	fi

	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-static \
		--enable-shape \
		--enable-sm \
		--enable-startup-notification \
		--enable-xsync \
		--enable-verbose-mode \
		--with-libcanberra \
		$(use_enable introspection)
}
