# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime gnome2-utils cmake-utils bzr

DESCRIPTION="Sharing your files easily and efficiently"
HOMEPAGE="https://launchpad.net/dropoff"
EBZR_REPO_URI="lp:dropoff"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	x11-libs/granite
    x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	dev-util/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="$(type -p valac-0.16)"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icons_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

