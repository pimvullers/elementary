# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils cmake-utils bzr

DESCRIPTION="The sexiest dictionary on Earth and Jupiter"
HOMEPAGE="https://launchpad.net/lingo-dictionary"
EBZR_REPO_URI="lp:lingo-dictionary"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

RDEPEND="
	dev-db/sqlite:3
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee
	net-libs/libsoup
	x11-libs/gtk+:3
	x11-libs/granite"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=( AUTHORS COPYING )
}

src_configure() {
	local mycmakeargs=(
		-DGSETTINGS_COMPILE=OFF
		-DVALA_EXECUTABLE="$(type -p valac-0.16)"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update --uninstall
}

