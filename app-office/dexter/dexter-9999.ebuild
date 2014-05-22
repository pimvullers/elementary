# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit vala autotools-utils bzr

DESCRIPTION="Dexter is a sexy, simple address book with end users in mind"
HOMEPAGE="http://launchpad.net/dexter-contacts"
EBZR_REPO_URI="lp:dexter-contacts"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="nls static-libs"

RDEPEND="
	>=dev-libs/folks-0.6.1.1
	<dev-libs/folks-0.9
	dev-libs/glib:2
	dev-libs/libgee:0
	gnome-base/gnome-desktop:3
	>=gnome-extra/evolution-data-server-3.2
	<gnome-extra/evolution-data-server-3.5
	net-libs/gnome-online-accounts
	x11-libs/gtk+:3
	x11-libs/granite
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	AUTOTOOLS_AUTORECONF=yes

	DOCS=( AUTHORS COPYING NEWS README )
}

src_prepare() {
	use nls || sed -i 's# po##' Makefile.am

	autotools-utils_src_prepare
	vala_src_prepare
}
