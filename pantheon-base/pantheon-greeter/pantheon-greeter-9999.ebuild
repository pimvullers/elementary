# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils bzr

DESCRIPTION="Pantheon Login Screen for LightDM"
HOMEPAGE="https://launchpad.net/pantheon-greeter"
EBZR_REPO_URI="lp:pantheon-greeter"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-libs/libindicator:3
	media-libs/clutter-gtk:1.0
	x11-libs/granite
	x11-libs/gtk+:3
	x11-misc/lightdm"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="$(type -p valac-0.16)"
	)

	cmake-utils_src_configure
}

