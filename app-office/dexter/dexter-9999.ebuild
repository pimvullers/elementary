# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools-utils bzr

DESCRIPTION="Dexter is a sexy, simple address book with end users in mind"
HOMEPAGE="https://launchpad.net/dexter-rolodex"
EBZR_REPO_URI="lp:dexter-contacts"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls static-libs"

RDEPEND="
	>=dev-libs/folks-0.6.1.1
	>=dev-libs/glib-2.29.12:2
	dev-libs/libgee:0
	gnome-base/gnome-desktop:3
	<gnome-extra/evolution-data-server-3.5
	net-libs/gnome-online-accounts
	x11-libs/gtk+:3
	x11-libs/granite
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

pkg_setup() {
	DOCS=( AUTHORS COPYING NEWS README )
}

src_prepare() {
	./autogen.sh --version
}

src_configure() {
	local myeconfargs=(
		VALAC="$(type -p valac-0.16)"
	)

	autotools-utils_src_configure
}

