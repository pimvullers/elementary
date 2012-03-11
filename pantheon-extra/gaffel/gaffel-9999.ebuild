# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils bzr

DESCRIPTION="A simple yet flexible GTK dialog tool"
HOMEPAGE="https://launchpad.net/gaffel"
EBZR_REPO_URI="lp:gaffel"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	>=dev-libs/glib-2.26.0:2
    >=x11-libs/gtk+-3.0.8:3"
DEPEND="${RDEPEND}
	dev-lang/vala:0.16
	dev-util/pkgconfig"

pkg_setup() {
	DOCS=( COPYING README )
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="$(type -p valac-0.16)"
	)

	cmake-utils_src_configure
}

