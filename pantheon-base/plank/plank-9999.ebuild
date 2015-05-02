# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.22
VALA_USE_DEPEND=vapigen

inherit fdo-mime gnome2-utils vala autotools-utils bzr

DESCRIPTION="The dock for elementary Pantheon, stupidly simple"
HOMEPAGE="https://launchpad.net/plank https://launchpad.net/pantheon-dock"
EBZR_REPO_URI="lp:plank"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="debug nls static-libs"

CDEPEND="
	dev-libs/glib:2
	dev-libs/libgee:0.8
	dev-libs/libdbusmenu[gtk3]
	x11-libs/libX11
	x11-libs/libwnck:3
	x11-libs/bamf
	x11-libs/cairo
	x11-libs/gtk+:3"
RDEPEND="${CDEPEND}
	x11-themes/plank-theme-pantheon"
DEPEND="${CDEPEND}
	$(vala_depend)
	dev-util/intltool
	virtual/pkgconfig
	gnome-base/gnome-common
	nls? ( sys-devel/gettext )"

AUTOTOOLS_AUTORECONF=yes
AUTOTOOLS_IN_SOURCE_BUILD=yes

DOCS=( AUTHORS COPYING COPYRIGHT NEWS README )

src_prepare() {
	epatch_user

	autotools-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local myeconfargs=(
		$(use_enable debug)
		$(use_enable nls)
		--enable-gee-0.8
		--disable-apport
	)
	autotools-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
