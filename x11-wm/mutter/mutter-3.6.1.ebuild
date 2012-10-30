# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
GNOME2_LA_PUNT="yes"

inherit gnome2
if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

DESCRIPTION="GNOME 3 compositing window manager based on Clutter"
HOMEPAGE="http://git.gnome.org/browse/mutter/"

LICENSE="GPL-2+"
SLOT="0"
IUSE="+introspection test"
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

COMMON_DEPEND=">=x11-libs/pango-1.2[X,introspection?]
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf:2[introspection?]
	>=x11-libs/gtk+-3.3.7:3[introspection?]
	>=dev-libs/glib-2.25.11:2
	>=media-libs/clutter-1.9.10:1.0[introspection?]
	>=media-libs/cogl-1.9.6:1.0[introspection?]
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
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXrender

	gnome-extra/zenity

	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/intltool-0.35
	sys-devel/gettext
	virtual/pkgconfig
	test? ( app-text/docbook-xml-dtd:4.5 )
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xproto"
RDEPEND="${COMMON_DEPEND}
	!x11-misc/expocity"

src_prepare() {
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
		$(use_enable introspection)"

	# Compat with Ubuntu metacity themes (e.g. x11-themes/light-themes)
	epatch "${FILESDIR}/${PN}-3.2.1-ignore-shadow-and-padding.patch"

	gnome2_src_prepare
}
