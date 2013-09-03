# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/mutter/Attic/mutter-3.4.1-r1.ebuild,v 1.5 2013/03/30 17:30:51 eva dead $

EAPI="4"
GNOME2_LA_PUNT="yes"

inherit eutils gnome2

DESCRIPTION="GNOME 3 compositing window manager based on Clutter"
HOMEPAGE="http://git.gnome.org/browse/mutter/"
SRC_URI="${SRC_URI}
	http://dev.gentoo.org/~tetromino/distfiles/${PN}/${PN}-3.4.1-gtk-doc-syntax.patch.xz
	https://launchpad.net/~elementary-os/+archive/os-patches/+files/${PN}_${PV}-0ubuntu99~elementary6.debian.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="+introspection test xinerama"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND=">=x11-libs/pango-1.2[X,introspection?]
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf:2[introspection?]
	>=x11-libs/gtk+-3.3.7:3[X,introspection?]
	>=dev-libs/glib-2.25.11:2
	>=media-libs/clutter-1.9.10:1.0[introspection?]
	>=media-libs/cogl-1.9.6:1.0[introspection?]
	<media-libs/cogl-1.12:1.0[introspection?]
	>=media-libs/libcanberra-0.26[gtk3]
	>=x11-libs/startup-notification-0.7
	>=x11-libs/libXcomposite-0.2
	>=gnome-base/gsettings-desktop-schemas-3.3.0[introspection?]

	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libXrender

	gnome-extra/zenity

	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="${COMMON_DEPEND}
	>=app-text/gnome-doc-utils-0.8
	>=dev-util/intltool-0.35
	sys-devel/gettext
	test? ( app-text/docbook-xml-dtd:4.5 )
	xinerama? ( x11-proto/xineramaproto )
	virtual/pkgconfig
	x11-proto/xextproto
	x11-proto/xproto"
RDEPEND="${COMMON_DEPEND}
	!x11-misc/expocity"

pkg_setup() {
	DOCS="AUTHORS ChangeLog HACKING MAINTAINERS NEWS README *.txt doc/*.txt"
	G2CONF="${G2CONF}
		--disable-static
		--enable-shape
		--enable-sm
		--enable-startup-notification
		--enable-xsync
		--enable-verbose-mode
		--enable-compile-warnings=maximum
		--with-libcanberra
		$(use_enable introspection)
		$(use_enable xinerama)"
}

src_prepare() {
	for patch in `ls "${WORKDIR}/debian/patches/"*.patch`; do
		epatch ${patch}
	done

	# gobject-introspection-1.33 compat; in 3.5.x
	epatch "${WORKDIR}/${PN}-3.4.1-gtk-doc-syntax.patch"

	gnome2_src_prepare
}
