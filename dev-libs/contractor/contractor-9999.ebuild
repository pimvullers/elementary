# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils bzr

DESCRIPTION="A sharing service that allows source apps to send their data to registered destination apps"
HOMEPAGE="https://launchpad.net/contractor"
EBZR_REPO_URI="lp:contractor"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
    dev-libs/libgee
    dev-libs/glib:2"
DEPEND="${RDEPEND}
	|| (
	    dev-lang/vala:0.16
    	dev-lang/vala:0.14
	)
    dev-util/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="$(type -p valac-0.16 valac-0.14 | head -n1)"
	)

	cmake-utils_src_configure
}

