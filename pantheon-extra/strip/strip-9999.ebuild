# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit fdo-mime gnome2-utils cmake-utils bzr

DESCRIPTION="An elementary comic reader"
HOMEPAGE="https://launchpad.net/strip"
EBZR_REPO_URI="lp:strip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	x11-libs/granite
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	|| (
		dev-lang/vala:0.16
		dev-lang/vala:0.14
	)
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS README )
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE=$(type -p valac-0.16 valac-0.14 | head -n1)
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_schemas_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_schemas_update
}

