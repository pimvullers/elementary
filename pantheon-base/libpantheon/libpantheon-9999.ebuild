# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils bzr

DESCRIPTION="A library for interacting with various Pantheon Desktop Environment components"
HOMEPAGE="https://launchpad.net/libpantheon"
EBZR_REPO_URI="lp:libpantheon"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	|| (
		dev-lang/vala:0.16
		dev-lang/vala:0.14
	)
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=(AUTHORS COPYING COPYRIGHT NEWS README)
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="$(type -p valac-0.16 valac-0.14 | head -n1)"
	)

	cmake-utils_src_configure
}

