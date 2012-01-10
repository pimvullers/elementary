# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime gnome2-utils cmake-utils bzr

DESCRIPTION="Awesome RSS reader"
HOMEPAGE="https://launchpad.net/feedler"
EBZR_REPO_URI="lp:feedler"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-db/sqlheavy:0.1
	dev-libs/libxml2
	net-libs/libsoup
	net-libs/webkit-gtk:3
	x11-libs/granite
    x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.14"

pkg_setup() {
	DOCS=( AUTHORS COPYING )
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE=$(type -p valac-0.14)
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_schemas_update --uninstall
}

