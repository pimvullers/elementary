# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils bzr

DESCRIPTION="The application store designed for the Pantheon desktop."
HOMEPAGE="https://launchpad.net/appcenter"
EBZR_REPO_URI="lp:appcenter"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	app-admin/packagekit-base
	dev-db/sqlheavy:0.1
	dev-libs/libappstore
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee:0
	dev-libs/libpeas
	dev-libs/libunity
	x11-libs/granite
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.18
	virtual/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS COPYING README )
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.18)"
	)

	cmake-utils_src_configure
}

